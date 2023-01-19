From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Jan 2023 08:56:25 +0100
Subject: [PATCH 2/5] dt-bindings: soc: hpe: hpe,gxp-srom.yaml
In-Reply-To: <Y8jzsmC3azFgbZLP@enigma.ccjz.io>
References: <20230110042533.12894-1-clayc@hpe.com>
 <20230110042533.12894-3-clayc@hpe.com>
 <110af65f-9c18-524d-a073-ef7be60d1f5a@linaro.org>
 <Y8AIHDizIqu9u9BR@enigma.ccjz.io>
 <48cd3e28-f1db-487d-8971-473dc8c12c09@app.fastmail.com>
 <Y8VUOENIhe72sqMO@enigma.ccjz.io>
 <55f09599-b553-4429-aa79-ca99ccf95cda@app.fastmail.com>
 <Y8jzsmC3azFgbZLP@enigma.ccjz.io>
Message-ID: <66ef9643-b47e-428d-892d-7c1cbd358a5d@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 19, 2023, at 08:39, Clay Chang wrote:
> On Mon, Jan 16, 2023 at 04:18:59PM +0100, Arnd Bergmann wrote:
>
> Sorry for not saying it clearly. I meant to put those HPE BMC related
> drivers that are "not specific" to a particular subsystem in
> drivers/soc/hpe. For those fit into some existing subsystems go to their
> designated places.

Ok, that makes sense. I'm just trying to reduce the number
of drivers that fit into this category.

>> >> Again, it's hard for me to tell why this even needs to be runtime
>> >> configurable, please try to describe what type of application
>> >> would access the sysfs interface here, and why this can't just
>> >> be set to a fixed value by bootloader or kernel without user
>> >> interaction.
>> >
>> > The register is used for communication and synchronization between the
>> > BMC and the host. During runtime, user-space daemons configures the
>> > value of the register for interactions.
>> 
>> That does not sound very specific. What is the subsystem on the
>> host that this communicates with? Can you put the driver into the
>> same subsystem?
>
> This is a control register in the BMC chip that partially controls host
> boot behaviors. When writing to the register, privileged mode is
> required. That's why we rely on a kernel driver for writing to the
> control register. And, there is no corresponding subsystem in the host
> OS. For this case, is it acceptable to put this driver under
> drivers/soc/hpe?

I see. So this sounds like it might be generic BMC feature, which would
be nice to handle consistently for all BMC families. We had some
discussions about other BMC features in the past, but don't remember
what the overall consensus was, so I'm adding the openbmc list and
as well as aspeed and npcm maintainers to Cc.

The part I'm still missing is what type of userspace makes this
decision on the BMC side, and whether that might already have a
generalized interface. If there is, maybe part of that interface
can be abstracted in the kernel.

    Arnd
