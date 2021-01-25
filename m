From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 25 Jan 2021 14:44:37 +1030
Subject: =?UTF-8?Q?Re:_[PATCH_v5_4/5]_pinctrl:_aspeed-g5:_Adapt_to_new_LPC_device?=
 =?UTF-8?Q?_tree_layout?=
In-Reply-To: <20210114131622.8951-5-chiawei_wang@aspeedtech.com>
References: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
 <20210114131622.8951-5-chiawei_wang@aspeedtech.com>
Message-ID: <2ee34adb-ca7a-43f5-9101-f48909667962@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 14 Jan 2021, at 23:46, Chia-Wei, Wang wrote:
> Add check against LPC device v2 compatible string to
> ensure that the fixed device tree layout is adopted.
> The LPC register offsets are also fixed accordingly.
> 
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>

Using a Witherspoon (AST2500):

Tested-by: Andrew Jeffery <andrew@aj.id.au>
