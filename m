From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Mon, 30 Sep 2024 17:00:46 +0300
Subject: [PATCH 00/45] media: Use string_choice helpers
In-Reply-To: <7D358236-19F8-4F94-89A0-F379F193971F@md.metrocast.net>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
 <20240930122157.GF31662@pendragon.ideasonboard.com>
 <4873f3a0-bd82-4ace-a783-10ea137284d6@xs4all.nl>
 <7D358236-19F8-4F94-89A0-F379F193971F@md.metrocast.net>
Message-ID: <f04f0057-626b-471f-b0a4-56ba30dbf8cf@stanley.mountain>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 30, 2024 at 08:57:44AM -0400, Andy Walls wrote:
> No human being really code reviews sweeping editorial change like these thoroughly.

I wonder if there is some way to verify that people are actually running the
Coccinelle script that they say they are without doing anything extra on the
side.

I use a script to filter out mechanical changes.

https://github.com/error27/rename_rev

It's kind of a pain in the butt to review something like this.  The command
would be something like:

rename_rev.pl -e 's/(.*?,|^\W+)(.*) \? "enabled" : "disabled"/$1str_enabled_disabled($2)/' -e 's/(.*?,|^\W+)(.*) \? "enable" : "disable"/$1str_enable_disable($2)/' -e 's/(.*,|^\W+)(.*) \? "low" : "high"/$1str_low_high($2)/'  -e 's/(.*,|^\W+)(.*) \? "on" : "off"/$1str_on_off($2)/' -e 's/(.*,|^\W+)(.*) \? "true" : "false"/$1str_true_false($2)/'  -e 's/(.*,|^\W+)(.*) \? "high" : "low"/$1str_high_low($2)/' -e 's/(.*,|^\W+)(.*) \? "read" : "write"/$1str_read_write($2)/'

For every email in the series there was another new str_foo_bar() function so
the command line kept getting longer and longer.  It doesn't work perfectly, but
it's often good enough so I can spot the interesting bits.

regards,
dan carpenter

