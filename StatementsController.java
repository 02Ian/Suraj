
package com.capgemini.stargate.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.capgemini.stargate.controller.model.Statements;
import com.capgemini.stargate.controller.model.StatementsRequest;
import com.capgemini.stargate.service.StatementsService;


/**
 * No description
 * (Generated with springmvc-raml-parser v.2.0.0)
 * 
 */
@RestController
@RequestMapping(value = "/api/account/statements", produces = "application/json")
@Validated
public class StatementsController {

	@Autowired
	private StatementsService service;
    /**
     * return all statements
     * 
     */
    @RequestMapping(value = "", method = RequestMethod.POST)
    public Statements createStatementsRequest(
        @Valid
        @RequestBody
        StatementsRequest statementsRequest) {
    	Statements data=service.getStatementsDetailsBasedOnAccountId(statementsRequest.getAccountId());
        return data;
    }

}
