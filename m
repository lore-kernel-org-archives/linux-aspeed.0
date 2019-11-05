From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Tue, 5 Nov 2019 15:59:46 +0100
Subject: [PATCH 00/62] Add definition for GPIO direction
In-Reply-To: <a967c764d135ab0f96f6b1df62ac91426c935b44.camel@fi.rohmeurope.com>
References: <cover.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
 <20191105122042.GO32742@smile.fi.intel.com>
 <4e6fa62d7022c7b1426477a150a93c899725f5b0.camel@fi.rohmeurope.com>
 <20191105131038.duol3rwwkbuvgvwv@pengutronix.de>
 <938a5ec7b41ae9ce7b0de83764d6b774cfdaa781.camel@fi.rohmeurope.com>
 <20191105133604.d2xcasxw7pwzwvh7@pengutronix.de>
 <a967c764d135ab0f96f6b1df62ac91426c935b44.camel@fi.rohmeurope.com>
Message-ID: <20191105145946.2ye6ujvqzn2d6fqd@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Matti,

On Tue, Nov 05, 2019 at 02:00:02PM +0000, Vaittinen, Matti wrote:
> On Tue, 2019-11-05 at 14:36 +0100, Uwe Kleine-K?nig wrote:
> Thanks Uwe! That was kind! I'm on Fedora but I guess I can find the
> multiarch binutils :) I'll try that tomorrow when I'm back at the
> office. Let's see what kind of results I can get from it.
> 
> Unfortunately bunch of the GPIOs depend on x86 - so I need to see what
> I can compile in with decent effort. For my compile test I just hacked
> the Makefile to force all in and added some dummy macros to fix few
> missing functions :| But I guess I can get some results.

Enable CONFIG_COMPILE_TEST and then you should be able to compile most
drivers also on the wrong architecture.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
