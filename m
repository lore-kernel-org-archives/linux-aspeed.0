From: Pratyush Yadav <p.yadav@ti.com>
Date: Mon, 24 Jan 2022 21:06:44 +0530
Subject: [PATCH] mtd: aspeed-smc: improve probe resilience
In-Reply-To: <d4ba6413-57ce-14c1-ed48-d00db2f74bd3@kaod.org>
References: <20211229143334.297305-1-patrick@stwcx.xyz>
 <20211229173411.l2bipmi4x3arqjoo@ti.com>
 <Yc3Qav+ULNdF5zRT@heinlein>
 <20211231102623.izaqlzjvracbbgmp@ti.com>
 <20220103171721.46c8e697@xps13> <YdSP6tKyQ2ZRUC+2@heinlein>
 <20220105063244.lno3xur64uepa7i5@ti.com>
 <d4ba6413-57ce-14c1-ed48-d00db2f74bd3@kaod.org>
Message-ID: <20220124153644.m3iwlvq5ld5cpbyz@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 23/01/22 11:44PM, C?dric Le Goater wrote:
> > > I had an offline discussion with someone who knew more history on this driver.
> > > My understanding is that the linux-aspeed team is aware of this being deprecated
> > > but that there was some missing support for interface training that nobody has
> > > gotten around to write?  If that is the case this really isn't even a "simple"
> > > port to a new API at this point.
> > 
> > Unless the controller needs some unique feature (I don't think it does
> > on a quick glance), the conversion should not be too difficult. For any
> > experienced developer, even if they are unfamiliar with the SPI MEM API,
> > I don't think it should take more than 2-3 days to do the conversion.
> > The code to program the registers would stay the same, all that needs to
> > change is the API through which it is accessed.
> 
> Writing a spimem driver is not a problem, I think people have done
> that in house. Aspeed has one for AST2600. We have one for u-boot
> I wrote sometime ago. I even have one for Linux but training comes
> with ugly hacks to fit in the current stack.
> 
> All Aspeed SoCs need training and that has been the problem for the
> last 4 years or so because we can not do training without knowing
> a minimum about the flash being trained :/ The previous framework
> offered a way to do a first scan and tune the delay settings
> afterwards. It worked pretty well on AST2400, AST2500 and AST2600
> even if more complex.
> 
> One alternative was to include the setting in the DT but the flash
> modules are not always soldered on the boards, at least on OpenPOWER
> systems which have sockets for them. The board are large, the wires
> long, the need is real, some chips freak out if not tuned correctly.
> 
> spimem needs an extension I think. Sorry I have not been able to
> push that forward. Lack of time and other tasks to address on the
> host side of the machine. This is really a software problem, we
> have the HW procedures ready. If a spimem expert could get involved
> to make a few proposals, I would be happy to help and do some testing.
> QEMU models are good enough for the software part. We can do the
> training validation on real HW when ready.

What information about the flash do you need for this training? I 
proposed a patch series [0] some time ago trying to implement training 
for TI SoCs. It did not get merged but I do intend to respin it and get 
it through. Would this API work for your tuning as well?

Also, I am curious how your training works. What data do you read for 
training delays? Where is it stored? In our case we need to flash a 
known pattern at some location (which is passed in via DT). Do you need 
to run it for every read transaction or just once after the flash is 
initialized?

[0] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=233504&state=%2A&archive=both

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
