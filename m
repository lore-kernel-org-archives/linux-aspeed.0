From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 31 May 2021 11:40:07 +0700
Subject: [PATCH v4 1/4] dt-bindings: mfd: Add bindings for Ampere Altra
 SMPro drivers
In-Reply-To: <ee17c000-6f70-84d9-f7a1-0d30b03dafab@os.amperecomputing.com>
References: <20210422090843.4614-1-quan@os.amperecomputing.com>
 <20210422090843.4614-2-quan@os.amperecomputing.com>
 <20210430201918.GA3806853@robh.at.kernel.org>
 <52550615-ae38-d88e-a597-29dc9c71755a@os.amperecomputing.com>
 <ee17c000-6f70-84d9-f7a1-0d30b03dafab@os.amperecomputing.com>
Message-ID: <aa5997f6-e629-e82b-ea0a-484888c0271f@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 18/05/2021 06:36, Quan Nguyen wrote:
> On 05/05/2021 15:44, Quan Nguyen wrote:
>> On 01/05/2021 03:19, Rob Herring wrote:
>>> On Thu, Apr 22, 2021 at 04:08:40PM +0700, Quan Nguyen wrote:
>>>> Adds device tree bindings for SMPro driver found on the Mt.Jade 
>>>> hardware
>>>> reference platform with Ampere's Altra Processor family.
>>>>
>>>> The SMpro co-processor on Ampere Altra processor family is to monitor
>>>> and report various data included hwmon-related info, RAS errors, and
>>>> other miscellaneous information. This parent SMPro MFD driver creates
>>>> a single simple register map to be shared by all sub-devices and leave
>>>> all the specific to be handled by the child drivers.
>>>
>>> Again, just because you have multiple functions aka MFD, that doesn't
>>> mean you need child nodes for each function. The only thing you have
>>> in DT is a register address. Does this vary? If so, how often? How many
>>> different versions of a DT do you currently or expect to have?
>>>
>> Hi Rob,
>>
>> Thank you for your review.
>> I will try to explain what I think below and expect to receive more 
>> comments to improve these patches. And if any misundertood, please 
>> help correct me.
>>
>> The idea is to keep the SMPro MFD as a simple generic register map and 
>> expect not to change or to handle any specific in this parent device 
>> driver. This is why we see the simple_mfd_i2c fit in this case.
>>
>> And so, all the specific details will be handled in child devices 
>> driver and we expect to have child nodes for these child devices. If 
>> the child node exist we can then add any specific if necessary later.
>>
>> One case is that, each socket (ie: the Ampere Altra processor) has it 
>> own SMPro co-processor instance in form of register map and each 
>> socket could be either slave or master. Some function may not 
>> available in slave socket but exist in master socket and we simply 
>> choose not to define the child node if that function not existed.
>>
>> The other case is that if there are multi instances of the same 
>> function in one SMPro MFD register map, then each instance might need 
>> to be differentiated by using is own register address or maybe a DT 
>> property. Then we can simply add them to the node of these instance.
>>
>> For your specific questions:
>>
>> + Does this vary ?
>> yes, I think so. The register address in each child nodes may vary if 
>> the SMPro co-processor firmware change its register map layout or 
>> maybe other instances of a function added. Child device drivers are 
>> expected to handle these changes if necessary.
>>
>> + About how often ?
>> I actually can't say how often but the purpose of this SMPro register 
>> map is to provide the info to the BMC. The BMC will need more info 
>> from the host so I think changes will be unavoidable.
>>
>> Please help with your comments
>> Thank you,
>> - Quan
>>
> Dear Rob,
> 
> do you have any suggestion to improve this patch?
> 
> - Quan

Dear Rob,

I'm sorry it's me again, I'm just hope you could share your thoughts on 
the DT node for sub-devices using simple-mfd-i2c drivers.

In commit 3abee4579484 ("mfd: Add simple regmap based I2C driver"), 
there is note that "Once the register map has been successfully 
initialised, any sub-devices represented by child nodes in Device Tree 
will be subsequently registered".

So it seems unavoidable to have DT nodes for sub-devices which uses 
simple-mfd-i2c. I'm a bit confused if DT nodes in this case should be 
avoided.

Please see 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch?id=3abee4579484c554961bb0af92a77adc0ebd791d

Thank you,
- Quan

PS:
Below is for quick reference:

 From 3abee4579484c554961bb0af92a77adc0ebd791d Mon Sep 17 00:00:00 2001
From: Michael Walle <michael@walle.cc>
Date: Mon, 14 Sep 2020 23:43:29 +0200
Subject: mfd: Add simple regmap based I2C driver

There are I2C devices which contain several different functions but
doesn't require any special access functions. For these kind of drivers
an I2C regmap should be enough.

Create an I2C driver which creates an I2C regmap and enumerates its
children. If a device wants to use this as its MFD core driver, it has
to add an individual compatible string. It may provide its own regmap
configuration.

Subdevices can use dev_get_regmap() on the parent to get their regmap
instance.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
  drivers/mfd/Kconfig          | 12 ++++++++++
  drivers/mfd/Makefile         |  1 +
  drivers/mfd/simple-mfd-i2c.c | 56 
++++++++++++++++++++++++++++++++++++++++++++
  3 files changed, 69 insertions(+)
  create mode 100644 drivers/mfd/simple-mfd-i2c.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 33df0837ab415..6e1a38944d282 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1162,6 +1162,18 @@ config MFD_SI476X_CORE
  	  To compile this driver as a module, choose M here: the
  	  module will be called si476x-core.

+config MFD_SIMPLE_MFD_I2C
+	tristate
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This driver creates a single register map with the intention for it
+	  to be shared by all sub-devices.
+
+	  Once the register map has been successfully initialised, any
+	  sub-devices represented by child nodes in Device Tree will be
+	  subsequently registered.
+
  config MFD_SM501
  	tristate "Silicon Motion SM501"
  	depends on HAS_DMA
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index a60e5f835283e..78d24a3e7c9e5 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -264,3 +264,4 @@ obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
  obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o

  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
+obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
new file mode 100644
index 0000000000000..28e96a246be11
--- /dev/null
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Simple MFD - I2C
+ *
+ * This driver creates a single register map with the intention for it 
to be
+ * shared by all sub-devices.  Children can use their parent's device 
structure
+ * (dev.parent) in order to reference it.
+ *
+ * Once the register map has been successfully initialised, any sub-devices
+ * represented by child nodes in Device Tree will be subsequently 
registered.
+ */
+
