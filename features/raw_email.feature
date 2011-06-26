Feature: Generate polnote from full email
  In order to increase efficiency gathering notes
  As a helper
  I want a pol note from a full raw email

  Scenario: Raw email is stripped to just the body
    Given a directory named "polnotes"
    Given I cd to "polnotes"
    And a file named "polnote" with:
    """
    Return-Path: <rms@gnu.org>
    X-Original-To: stallman-helpers@netpurgatory.com
    Delivered-To: x12197960@homiemail-mx22.g.dreamhost.com
    Received: from fencepost.gnu.org (fencepost.gnu.org [140.186.70.10])
    (using TLSv1 with cipher AES256-SHA (256/256 bits))
    (No client certificate requested)
    by homiemail-mx22.g.dreamhost.com (Postfix) with ESMTPS id E7DC72006A0;
    Fri, 24 Jun 2011 02:38:52 -0700 (PDT)
    Received: from rms by fencepost.gnu.org with local (Exim 4.71)
    (envelope-from <rms@gnu.org>)
    id 1Qa2qX-0004H6-LF; Fri, 24 Jun 2011 05:38:41 -0400
    Date: Fri, 24 Jun 2011 05:38:41 -0400
    Message-Id: <E1Qa2qX-0004H6-LF@fencepost.gnu.org>
    Content-Type: text/plain; charset=ISO-8859-15
    From: Richard Stallman <rms@gnu.org>
    To: stallman-org@gnu.org
    Subject: Pol note
    Reply-to: rms@gnu.org
    Content-Length: 567

    Text Here.

    http://test.com

    more text.

    -- 
    Dr Richard Stallman
    President, Free Software Foundation
    51 Franklin St
    Boston MA 02110
    USA
    www.fsf.org, www.gnu.org
    Skype: No way! That's nonfree (freedom-denying) software.
    Use free telephony http://directory.fsf.org/category/tel/
    """
    And I cd to ".."
    Given a file named "config.yml" with:
    """
    email_dir: polnotes
    """
    Given I run `rmsgen -c config.yml` interactively
    And I type "A title"
    And I type "Text"
    Then the output should contain:
    """ 
    Text Here.

    What is the text?
    """

    And the output should contain:
    """
    <p><a href='http://test.com'>Text</a> Here.</p>\n<p>more text.</p>
    """

    And the output should not contain:
    """
    Return-Path: <rms@gnu.org>
    X-Original-To: stallman-helpers@netpurgatory.com
    Delivered-To: x12197960@homiemail-mx22.g.dreamhost.com
    Received: from fencepost.gnu.org (fencepost.gnu.org [140.186.70.10])
    (using TLSv1 with cipher AES256-SHA (256/256 bits))
    (No client certificate requested)
    by homiemail-mx22.g.dreamhost.com (Postfix) with ESMTPS id E7DC72006A0;
    Fri, 24 Jun 2011 02:38:52 -0700 (PDT)
    Received: from rms by fencepost.gnu.org with local (Exim 4.71)
    (envelope-from <rms@gnu.org>)
    id 1Qa2qX-0004H6-LF; Fri, 24 Jun 2011 05:38:41 -0400
    Date: Fri, 24 Jun 2011 05:38:41 -0400
    Message-Id: <E1Qa2qX-0004H6-LF@fencepost.gnu.org>
    Content-Type: text/plain; charset=ISO-8859-15
    From: Richard Stallman <rms@gnu.org>
    To: stallman-org@gnu.org
    Subject: Pol note
    Reply-to: rms@gnu.org
    Content-Length: 567
    """

    And the output should not contain:

    """
    -- 
    Dr Richard Stallman
    President, Free Software Foundation
    51 Franklin St
    Boston MA 02110
    USA
    www.fsf.org, www.gnu.org
    Skype: No way! That's nonfree (freedom-denying) software.
    Use free telephony http://directory.fsf.org/category/tel/
    """
