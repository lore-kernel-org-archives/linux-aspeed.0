From: Vijay Khemka <vijaykhemka@fb.com>
Date: Thu, 30 May 2019 18:51:52 +0000
Subject: [PATCH 2/2] Docs: hwmon: pmbus: Add PXE1610 driver
In-Reply-To: <0a94e784-41a0-4f2d-f9f8-6b365a1e755e@roeck-us.net>
References: <20190529223511.4059120-1-vijaykhemka@fb.com>
 <20190529223511.4059120-2-vijaykhemka@fb.com>
 <0a94e784-41a0-4f2d-f9f8-6b365a1e755e@roeck-us.net>
Message-ID: <27E78CF3-FAE7-4B6F-ABD7-77F4AE1CD633@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 5/29/19, 6:05 PM, "Guenter Roeck" <groeck7 at gmail.com on behalf of linux@roeck-us.net> wrote:

    On 5/29/19 3:35 PM, Vijay Khemka wrote:
    > Added support for Infenion PXE1610 driver
    > 
    > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    > ---
    >   Documentation/hwmon/pxe1610 | 84 +++++++++++++++++++++++++++++++++++++
    >   1 file changed, 84 insertions(+)
    >   create mode 100644 Documentation/hwmon/pxe1610
    > 
    > diff --git a/Documentation/hwmon/pxe1610 b/Documentation/hwmon/pxe1610
    > new file mode 100644
    > index 000000000000..b5c83edf027a
    > --- /dev/null
    > +++ b/Documentation/hwmon/pxe1610
    > @@ -0,0 +1,84 @@
    > +Kernel driver pxe1610
    > +=====================
    > +
    > +Supported chips:
    > +  * Infinion PXE1610
    > +    Prefix: 'pxe1610'
    > +    Addresses scanned: -
    > +    Datasheet: Datasheet is not publicly available.
    > +
    > +  * Infinion PXE1110
    > +    Prefix: 'pxe1110'
    > +    Addresses scanned: -
    > +    Datasheet: Datasheet is not publicly available.
    > +
    > +  * Infinion PXM1310
    > +    Prefix: 'pxm1310'
    > +    Addresses scanned: -
    > +    Datasheet: Datasheet is not publicly available.
    > +
    > +Author: Vijay Khemka <vijaykhemka@fb.com>
    > +
    > +
    > +Description
    > +-----------
    > +
    > +PXE1610 is a Multi-rail/Multiphase Digital Controllers and
    > +it is compliant to Intel VR13 DC-DC converter specifications.
    > +
    
    And the others ?
This supports VR12 as well and I don't see this controller supports any other VR versions.
    
    > +
    > +Usage Notes
    > +-----------
    > +
    > +This driver can be enabled with kernel config CONFIG_SENSORS_PXE1610
    > +set to 'y' or 'm'(for module).
    > +
    The above does not really add value.
Ok, I will remove it.
    
    > +This driver does not probe for PMBus devices. You will have
    > +to instantiate devices explicitly.
    > +
    > +Example: the following commands will load the driver for an PXE1610
    > +at address 0x70 on I2C bus #4:
    > +
    > +# modprobe pxe1610
    > +# echo pxe1610 0x70 > /sys/bus/i2c/devices/i2c-4/new_device
    > +
    > +It can also be instantiated by declaring in device tree if it is
    > +built as a kernel not as a module.
    > +
    
    I assume you mean "built into the kernel".
    Why would devicetree based instantiation not work if the driver is built
    as module ?
Will correct statement here.
    
    > +
    > +Sysfs attributes
    > +----------------
    > +
    > +curr1_label		"iin"
    > +curr1_input		Measured input current
    > +curr1_alarm		Current high alarm
    > +
    > +curr[2-4]_label		"iout[1-3]"
    > +curr[2-4]_input		Measured output current
    > +curr[2-4]_crit		Critical maximum current
    > +curr[2-4]_crit_alarm	Current critical high alarm
    > +
    > +in1_label		"vin"
    > +in1_input		Measured input voltage
    > +in1_crit		Critical maximum input voltage
    > +in1_crit_alarm		Input voltage critical high alarm
    > +
    > +in[2-4]_label		"vout[1-3]"
    > +in[2-4]_input		Measured output voltage
    > +in[2-4]_lcrit		Critical minimum output voltage
    > +in[2-4]_lcrit_alarm	Output voltage critical low alarm
    > +in[2-4]_crit		Critical maximum output voltage
    > +in[2-4]_crit_alarm	Output voltage critical high alarm
    > +
    > +power1_label		"pin"
    > +power1_input		Measured input power
    > +power1_alarm		Input power high alarm
    > +
    > +power[2-4]_label	"pout[1-3]"
    > +power[2-4]_input	Measured output power
    > +
    > +temp[1-3]_input		Measured temperature
    > +temp[1-3]_crit		Critical high temperature
    > +temp[1-3]_crit_alarm	Chip temperature critical high alarm
    > +temp[1-3]_max		Maximum temperature
    > +temp[1-3]_max_alarm	Chip temperature high alarm
    > 
    
    

