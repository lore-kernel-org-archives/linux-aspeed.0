From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 07 May 2021 16:37:19 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v3_4/5]_mmc:_sdhci-of-aspeed:_Add_a_helper_for_upda?=
 =?UTF-8?Q?ting_capability_register.?=
In-Reply-To: <20210507065918.GE23749@aspeedtech.com>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
 <20210506100312.1638-5-steven_lee@aspeedtech.com>
 <fecc9021-ab4b-4047-a664-47b1bd867cb3@www.fastmail.com>
 <20210507065918.GE23749@aspeedtech.com>
Message-ID: <e895e05b-fdcc-4192-befe-500c386ac64a@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 7 May 2021, at 16:29, Steven Lee wrote:
> The 05/07/2021 10:13, Andrew Jeffery wrote:
> > > +/*
> > > + * The function sets the mirror register for updating
> > > + * capbilities of the current slot.
> > > + *
> > > + *   slot | capability  | caps_reg | mirror_reg
> > > + *   -----|-------------|----------|------------
> > > + *     0  | CAP1_1_8V   | SDIO140  |   SDIO10
> > > + *     0  | CAP2_SDR104 | SDIO144  |   SDIO14
> > > + *     1  | CAP1_1_8V   | SDIO240  |   SDIO20
> > > + *     1  | CAP2_SDR104 | SDIO244  |   SDIO24
> > 
> > It would be nice to align the columns to improve readability.
> > 
> 
> Columns seems are aligned in my mail client(mutt) and my editor(vim).
> I paste the above comment in Notepad++, columns are aligned as well.
> 

Ah, it's probably my mail client then. Sorry for the noise!

Andrew
