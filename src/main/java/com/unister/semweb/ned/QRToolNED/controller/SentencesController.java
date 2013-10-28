package com.unister.semweb.ned.QRToolNED.controller;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.unister.semweb.ned.QRToolNED.datatypes.Candidate;
import com.unister.semweb.ned.QRToolNED.datatypes.Label;
import com.unister.semweb.ned.QRToolNED.datatypes.TextWithLabels;
import com.unister.semweb.ned.QRToolNED.db.DbAdapter;

@SuppressWarnings("serial")
@Controller
@Scope("session")
public class SentencesController implements Serializable {

    @Autowired
    private DbAdapter dbAdapter;

    @RequestMapping(method = RequestMethod.GET, value = "/")
    public String login(Model model) throws Exception {
        // get session User name
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();
        // select texts that aren't voted by the user and less voted than 5 times
        TextWithLabels text = dbAdapter.getTextForUser(username);
        if (text == null) {
            return "redirect:/contributers";
        }

        // insert labels into text via html
        String textWithMarkups = markupText(text);

        // insert user and textId
        model.addAttribute("userID", username);
        model.addAttribute("textID", text.getId());

        // insert text into model
        model.addAttribute("textWithMarkups", textWithMarkups);
        model.addAttribute("text", text);

        return "/login";
    }

    private String markupText(TextWithLabels text) {
        List<String> textParts = new ArrayList<String>();
        List<Label> labels = text.getLabels();
        String originalText = text.getText();
        // start with the last label and add the parts of the new text beginning with its end to the array
        // Note that we are expecting that the labels are sorted descending by there position in the text!
        int startFormerLabel = originalText.length();
        for (Label currentLabel : labels) {
            // proof if this label undercuts the last one.
            if (startFormerLabel >= currentLabel.getEnd()) {
                // append the text between this label and the former one
                textParts.add(originalText.substring(currentLabel.getEnd(), startFormerLabel));
                // append the markedup label
                textParts.add(currentLabel.getMarkedupLabel());
                // remember the start position of this label
                startFormerLabel = currentLabel.getStart();
            }
            else {
                System.out.println("Label undercuts another label. TextId: " + text.getId());
            }
        }
        textParts.add(originalText.substring(0, startFormerLabel));
        // Form the new text beginning with its end
        StringBuilder textWithMarkups = new StringBuilder();
        for (int i = textParts.size() - 1; i >= 0; --i) {
            textWithMarkups.append(textParts.get(i));
        }
        return textWithMarkups.toString();
    }

    @RequestMapping(method = RequestMethod.POST, value = "/getData")
    public ModelAndView next(Model model, HttpServletResponse response, HttpServletRequest request) throws Exception {
        // if the same label is annotated as something different it will be saved as such an other thing
        String userName = request.getParameter("userID");
        Integer textId = Integer.valueOf(request.getParameter("textID"));
        String splittedValue[];
        for (Object key : request.getParameterMap().keySet()) {
            String keyString = (String) key;
            String[] values = (String[]) request.getParameterMap().get(keyString);
            if (keyString.startsWith("newLabel:")) {
                // the expected form is "newLabel:<label>//<start>//<end>
                splittedValue = values[0].replace("newLabel:", "").split("//");
                String label = splittedValue[0];
                Integer start = Integer.valueOf(splittedValue[1]);
                Integer end = Integer.valueOf(splittedValue[2]);

                dbAdapter.insertNotIdentifiedNE(textId, label, start, end);
            } else if (keyString.startsWith("candidate:")) {
                // the expected form is "candidate:<textHasLabelId>,<uri>
                splittedValue = values[0].replace("candidate:", "").split(",");
                Integer textHasLabelId = Integer.valueOf(splittedValue[0]);
                Integer candidateId = Integer.valueOf(splittedValue[1]);

                dbAdapter.insertVoting(textHasLabelId, userName, candidateId);
                if (candidateId == Candidate.OTHER_ENTITY_CANDIDATE_ID)
                {
                    // save another entity url recommended by the user not in the recommendation list
                    String textAreaKey = textHasLabelId + ",otherDesc";
                    String[] vals = (String[]) request.getParameterMap().get(textAreaKey);
                    assert (vals.length == 1);

                    dbAdapter.insertAnotherEntity(textHasLabelId, userName, vals[0]);
                }
            }
        }
        // store the information that the user saw this text
        dbAdapter.insertUserSawText(userName, textId);

        return new ModelAndView("redirect:/");
    }

    public DbAdapter getDbAdapter() {
        return dbAdapter;
    }

    public void setDbAdapter(DbAdapter dbAdapter) {
        this.dbAdapter = dbAdapter;
    }
}
