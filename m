From: Winiarska, Iwona <iwona.winiarska@intel.com>
Date: Thu, 5 Aug 2021 21:42:04 +0000
Subject: [PATCH 13/14] docs: hwmon: Document PECI drivers
In-Reply-To: <4e840768-0315-6241-e988-9a3165a31a86@roeck-us.net>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <20210712220447.957418-14-iwona.winiarska@intel.com>
 <20210727225808.GU8018@packtop>
 <ea5621698508a800cea59b5533f8845b9f0befc6.camel@intel.com>
 <20210804175203.GY8018@packtop>
 <4e840768-0315-6241-e988-9a3165a31a86@roeck-us.net>
Message-ID: <6891496eabcc6f9cacec4fea505fb757ea9c11fc.camel@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2021-08-04 at 11:05 -0700, Guenter Roeck wrote:
> On 8/4/21 10:52 AM, Zev Weiss wrote:
> > On Mon, Aug 02, 2021 at 06:37:30AM CDT, Winiarska, Iwona wrote:
> > > On Tue, 2021-07-27 at 22:58 +0000, Zev Weiss wrote:
> > > > On Mon, Jul 12, 2021 at 05:04:46PM CDT, Iwona Winiarska wrote:
> > > > > From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> > > > > 
> > > > > Add documentation for peci-cputemp driver that provides DTS thermal
> > > > > readings for CPU packages and CPU cores and peci-dimmtemp driver that
> > > > > provides DTS thermal readings for DIMMs.
> > > > > 
> > > > > Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> > > > > Co-developed-by: Iwona Winiarska <iwona.winiarska@intel.com>
> > > > > Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> > > > > Reviewed-by: Pierre-Louis Bossart
> > > > > <pierre-louis.bossart@linux.intel.com>
> > > > > ---
> > > > > Documentation/hwmon/index.rst???????? |? 2 +
> > > > > Documentation/hwmon/peci-cputemp.rst? | 93 +++++++++++++++++++++++++++
> > > > > Documentation/hwmon/peci-dimmtemp.rst | 58 +++++++++++++++++
> > > > > MAINTAINERS?????????????????????????? |? 2 +
> > > > > 4 files changed, 155 insertions(+)
> > > > > create mode 100644 Documentation/hwmon/peci-cputemp.rst
> > > > > create mode 100644 Documentation/hwmon/peci-dimmtemp.rst
> > > > > 
> > > > > diff --git a/Documentation/hwmon/index.rst
> > > > > b/Documentation/hwmon/index.rst
> > > > > index bc01601ea81a..cc76b5b3f791 100644
> > > > > --- a/Documentation/hwmon/index.rst
> > > > > +++ b/Documentation/hwmon/index.rst
> > > > > @@ -154,6 +154,8 @@ Hardware Monitoring Kernel Drivers
> > > > > ??? pcf8591
> > > > > ??? pim4328
> > > > > ??? pm6764tr
> > > > > +?? peci-cputemp
> > > > > +?? peci-dimmtemp
> > > > > ??? pmbus
> > > > > ??? powr1220
> > > > > ??? pxe1610
> > > > > diff --git a/Documentation/hwmon/peci-cputemp.rst
> > > > > b/Documentation/hwmon/peci-cputemp.rst
> > > > > new file mode 100644
> > > > > index 000000000000..d3a218ba810a
> > > > > --- /dev/null
> > > > > +++ b/Documentation/hwmon/peci-cputemp.rst
> > > > > @@ -0,0 +1,93 @@
> > > > > +.. SPDX-License-Identifier: GPL-2.0-only
> > > > > +
> > > > > +Kernel driver peci-cputemp
> > > > > +==========================
> > > > > +
> > > > > +Supported chips:
> > > > > +???????One of Intel server CPUs listed below which is connected to a
> > > > > PECI
> > > > > bus.
> > > > > +???????????????* Intel Xeon E5/E7 v3 server processors
> > > > > +???????????????????????Intel Xeon E5-14xx v3 family
> > > > > +???????????????????????Intel Xeon E5-24xx v3 family
> > > > > +???????????????????????Intel Xeon E5-16xx v3 family
> > > > > +???????????????????????Intel Xeon E5-26xx v3 family
> > > > > +???????????????????????Intel Xeon E5-46xx v3 family
> > > > > +???????????????????????Intel Xeon E7-48xx v3 family
> > > > > +???????????????????????Intel Xeon E7-88xx v3 family
> > > > > +???????????????* Intel Xeon E5/E7 v4 server processors
> > > > > +???????????????????????Intel Xeon E5-16xx v4 family
> > > > > +???????????????????????Intel Xeon E5-26xx v4 family
> > > > > +???????????????????????Intel Xeon E5-46xx v4 family
> > > > > +???????????????????????Intel Xeon E7-48xx v4 family
> > > > > +???????????????????????Intel Xeon E7-88xx v4 family
> > > > > +???????????????* Intel Xeon Scalable server processors
> > > > > +???????????????????????Intel Xeon D family
> > > > > +???????????????????????Intel Xeon Bronze family
> > > > > +???????????????????????Intel Xeon Silver family
> > > > > +???????????????????????Intel Xeon Gold family
> > > > > +???????????????????????Intel Xeon Platinum family
> > > > > +
> > > > > +???????Datasheet: Available from
> > > > > http://www.intel.com/design/literature.htm
> > > > > +
> > > > > +Author: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> > > > > +
> > > > > +Description
> > > > > +-----------
> > > > > +
> > > > > +This driver implements a generic PECI hwmon feature which provides
> > > > > Digital
> > > > > +Thermal Sensor (DTS) thermal readings of the CPU package and CPU
> > > > > cores that
> > > > > are
> > > > > +accessible via the processor PECI interface.
> > > > > +
> > > > > +All temperature values are given in millidegree Celsius and will be
> > > > > measurable
> > > > > +only when the target CPU is powered on.
> > > > > +
> > > > > +Sysfs interface
> > > > > +-------------------
> > > > > +
> > > > > +=======================
> > > > > =======================================================
> > > > > +temp1_label????????????"Die"
> > > > > +temp1_input????????????Provides current die temperature of the CPU
> > > > > package.
> > > > > +temp1_max??????????????Provides thermal control temperature of the
> > > > > CPU
> > > > > package
> > > > > +???????????????????????which is also known as Tcontrol.
> > > > > +temp1_crit?????????????Provides shutdown temperature of the CPU
> > > > > package
> > > > > which
> > > > > +???????????????????????is also known as the maximum processor
> > > > > junction
> > > > > +???????????????????????temperature, Tjmax or Tprochot.
> > > > > +temp1_crit_hyst????????????????Provides the hysteresis value from
> > > > > Tcontrol
> > > > > to Tjmax of
> > > > > +???????????????????????the CPU package.
> > > > > +
> > > > > +temp2_label????????????"DTS"
> > > > > +temp2_input????????????Provides current DTS temperature of the CPU
> > > > > package.
> > > > 
> > > > Would this be a good place to note the slightly counter-intuitive nature
> > > > of DTS readings?? i.e. add something along the lines of "The DTS sensor
> > > > produces a delta relative to Tjmax, so negative values are normal and
> > > > values approaching zero are hot."? (In my experience people who aren't
> > > > already familiar with it tend to think something's wrong when a CPU
> > > > temperature reading shows -50C.)
> > > 
> > > I believe that what you're referring to is a result of "GetTemp", and
> > > we're
> > > using it to calculate "Die" sensor values (temp1).
> > > The sensor value is absolute - we don't expose "raw" thermal sensor value
> > > (delta) anywhere.
> > > 
> > > DTS sensor is exposing temperature value scaled to fit DTS 2.0 thermal
> > > profile:
> > > https://www.intel.com/content/www/us/en/processors/xeon/scalable/xeon-scalable-thermal-guide.html
> > > (section 5.2.3.2)
> > > 
> > > Similar to "Die" sensor - it's also exposed in absolute form.
> > > 
> > > I'll try to change description to avoid confusion.
> > > 
> > 
> > When I tested the patch series by applying it to my OpenBMC kernel, the
> > temp2_input sysfs file produced negative numbers (as has been the case
> > with previous iterations of the PECI patchset).? Is that expected?? From
> > what Guenter has said it sounds like that's going to need to change so
> > that the temperature readings are all in "normal" millidegrees C
> > (that is, relative to the freezing point of water).
> > 
> 
> Correct, the temperature is expected to be reported in millidegrees C
> per hwmon ABI. Everything else is unacceptable. That makes me wonder what
> "raw" and "absolute" means. Negative numbers suggest that, whatever is
> reported today, it is not millidegrees C.

Let's say we have two values: "base" and "delta". Both are in milidegrees C.
"absolute" means that the sensor value exposed to userspace is calculated as:
base - delta (or base + delta, depending on sensor).
"relative" would mean that we expose "delta" to userspace as sensor value.

For peci-cputemp (and dimmtemp) we're exposing sensors in "absolute" form.

I contacted Zev and we found that the platform he uses has a different format
for the "raw" value ("delta" in the example above) of this particular sensor
(S8.8 instead of S10.6), which means that we're subtracting significantly larger
number than we should, resulting in sensor going into negative.

On the platform I'm using for development purpose, sampling Die and DTS values
returned:
Die 26344
DTS 26329

The platform that Zev used is currently not supported by peci-cpu, however, I
went through the specs, and it looks like some of the older supported platforms
are also using S8.8.
I'll fix this in v3.

Thanks
-Iwona

> 
> Guenter

