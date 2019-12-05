From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 05 Dec 2019 15:45:17 +1030
Subject: =?UTF-8?Q?Re:_[PATCH_2/3]_ipmi:_kcs:_Finish_configuring_ASPEED_KCS_devic?=
 =?UTF-8?Q?e_before_enable?=
In-Reply-To: <20191203134026.GI18165@minyard.net>
References: <cover.5630f63168ad5cddf02e9796106f8e086c196907.1575376664.git-series.andrew@aj.id.au>
 <84315a29b453068373c096c03433e3a326731988.1575376664.git-series.andrew@aj.id.au>
 <20191203134026.GI18165@minyard.net>
Message-ID: <cd76d709-683b-44c0-b29f-d31c9dddc75e@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 4 Dec 2019, at 00:10, Corey Minyard wrote:
> On Tue, Dec 03, 2019 at 11:08:24PM +1030, Andrew Jeffery wrote:
> > The currently interrupts are configured after the channel was enabled.
> 
> How about:
> 
> The interrupts were configured after the channel was enabled, configure
> them before so they will work.

Hah, yes, that commit message did get a bit mangled. I'll update it.

Thanks,

Andrew
