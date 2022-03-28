From: Ansuel Smith <ansuelsmth@gmail.com>
Date: Mon, 28 Mar 2022 13:55:01 +0200
Subject: [RFC PATCH 1/1] ARM/arm64: categorize dts in arm dir and fix
 dependency in arm64
In-Reply-To: <20220328082858.GJ7371@axis.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <20220328000915.15041-2-ansuelsmth@gmail.com>
 <20220328082858.GJ7371@axis.com>
Message-ID: <YkGiFa9DSKpsSZou@Ansuel-xps.localdomain>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 28, 2022 at 10:28:58AM +0200, Jesper Nilsson wrote:
> Hi Ansuel,
> 
> On Mon, Mar 28, 2022 at 02:09:15AM +0200, Ansuel Smith wrote:
> > - Categorize every dts in arm directory in subdirectory
> > - Fix Makefile to address for the arm subdirectory
> > - Fix any arm64 dependency
> > [...]
> >  arch/arm/boot/dts/axix/Makefile               |    3 +
> >  .../boot/dts/{ => axix}/artpec6-devboard.dts  |    0
> >  arch/arm/boot/dts/{ => axix}/artpec6.dtsi     |    0
> 
> All ARTPEC platforms should be in a directory called "axis".
> Otherwise LGTM.
> 
> Thanks!
> 
> /^JN - Jesper Nilsson
> -- 
>                Jesper Nilsson -- jesper.nilsson at axis.com

Will do the change! Noted.

-- 
	Ansuel
