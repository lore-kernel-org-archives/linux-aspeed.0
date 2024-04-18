From: Winiarska, Iwona <iwona.winiarska@intel.com>
Date: Thu, 18 Apr 2024 13:41:09 +0000
Subject: [PATCH] peci: aspeed: Clear clock_divider value before setting it
In-Reply-To: <7b0ef5c90138e8c1d1829de249a480709170141b.camel@codeconstruct.com.au>
References: <20240417134849.5793-1-iwona.winiarska@intel.com>
	 <7b0ef5c90138e8c1d1829de249a480709170141b.camel@codeconstruct.com.au>
Message-ID: <7520ac6ef7afae66f9b1636e5806ff2bfd93584d.camel@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2024-04-18 at 09:11 +0930, Andrew Jeffery wrote:
> Hi Iwona,
> 
> On Wed, 2024-04-17 at 15:48 +0200, Iwona Winiarska wrote:
> > PECI clock divider is programmed on 10:8 bits of PECI Control register.
> > Before setting a new value, clear bits read from hardware.
> > 
> > Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> 
> I think it would be best to add a Fixes: tag and Cc: stable in
> accordance with the stable tree rules. Are you happy to do so?

Hi!

Technically, the initial value of this register should be 0, but I've added the
clear just to be on the safe side and to not have to rely on that.
I don't think we're ever programming invalid values in the real-world scenarios,
and because of that - I don't think this is stable material.

Thanks
-Iwona

> 
> Andrew
> 
