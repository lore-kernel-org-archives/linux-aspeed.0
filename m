From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 27 May 2021 10:27:37 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v1_1/4]_dt-bindings:_aspeed-sgpio:_Convert_txt_bind?=
 =?UTF-8?Q?ings_to_yaml.?=
In-Reply-To: <20210526094609.14068-2-steven_lee@aspeedtech.com>
References: <20210526094609.14068-1-steven_lee@aspeedtech.com>
 <20210526094609.14068-2-steven_lee@aspeedtech.com>
Message-ID: <5c0670b1-269c-4aae-8639-c0866ac90dc9@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Steven,

On Wed, 26 May 2021, at 19:16, Steven Lee wrote:
> SGPIO bindings should be converted as yaml format.
> In addition to the file conversion, a new property max-ngpios is
> added in the yaml file as well.
> The new property is required by the enhanced sgpio driver for
> making the configuration of the max number of gpio pins more flexible.

Please add the new property in a separate patch to the YAML conversion. 
Having changes to the properties in addition to switching to dt schema 
makes it harder to catch errors, and it seems Rob's bot has already 
picked up some.

Reviewing the changes as separate patches means its easier to give you 
a Reviewed-by tag on that patches I'm happy with.

Andrew
