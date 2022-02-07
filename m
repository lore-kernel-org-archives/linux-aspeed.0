From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 7 Feb 2022 15:41:07 +0300
Subject: [bug report] pinctrl: aspeed: Improve debug output
Message-ID: <20220207124107.GA19955@kili>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Andrew Jeffery,

This is a semi-automatic email about new static checker warnings.

The patch aa639e443704: "pinctrl: aspeed: Improve debug output" from
Jul 1, 2020, leads to the following Smatch complaint:

    ./drivers/pinctrl/aspeed/pinctrl-aspeed.c:241 aspeed_pinmux_set_mux()
    warn: variable dereferenced before check 'pdesc' (see line 239)

./drivers/pinctrl/aspeed/pinctrl-aspeed.c
   238	
   239			pr_debug("Muxing pin %s for %s\n", pdesc->name, pfunc->name);
                                                           ^^^^^^^^^^^
Dereference

   240	
   241			if (!pdesc)
                             ^^^^^
Checked too late.

   242				return -EINVAL;
   243	

regards,
dan carpenter
