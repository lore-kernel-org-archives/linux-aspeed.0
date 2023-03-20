From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 20 Mar 2023 14:46:47 +0200
Subject: [PATCH v8 10/13] hwmon: peci: Add cputemp driver
In-Reply-To: <ZBhHS7v+98NK56is@home.paul.comp>
References: <20220208153639.255278-1-iwona.winiarska@intel.com>
 <20220208153639.255278-11-iwona.winiarska@intel.com>
 <ZBhHS7v+98NK56is@home.paul.comp>
Message-ID: <ZBhVt74i1DSoa+bE@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 20, 2023 at 02:45:15PM +0300, Paul Fertser wrote:
> Hello,
> 
> We are seeing wrong DTS temperatures on at least "Intel(R) Xeon(R)
> Bronze 3204 CPU @ 1.90GHz" and most probably other Skylake Xeon CPUs
> are also affected, see inline.

Thanks for the report! I guess we need a fix for this indeed.

> On Tue, Feb 08, 2022 at 04:36:36PM +0100, Iwona Winiarska wrote:
> > Add peci-cputemp driver for Digital Thermal Sensor (DTS) thermal
> > readings of the processor package and processor cores that are
> > accessible via the PECI interface.
> ...
> > +static const struct cpu_info cpu_hsx = {
> > +	.reg		= &resolved_cores_reg_hsx,
> > +	.min_peci_revision = 0x33,
> > +	.thermal_margin_to_millidegree = &dts_eight_dot_eight_to_millidegree,
> > +};
> > +
> > +static const struct cpu_info cpu_icx = {
> > +	.reg		= &resolved_cores_reg_icx,
> > +	.min_peci_revision = 0x40,
> > +	.thermal_margin_to_millidegree = &dts_ten_dot_six_to_millidegree,
> > +};
> ...
> > +	{
> > +		.name = "peci_cpu.cputemp.skx",
> > +		.driver_data = (kernel_ulong_t)&cpu_hsx,
> > +	},
> 
> With this configuration we get this data:
> 
> /sys/bus/peci/devices/0-30/peci_cpu.cputemp.skx.48/hwmon/hwmon15# grep . temp[123]_{label,input}
> temp1_label:Die
> temp2_label:DTS
> temp3_label:Tcontrol
> temp1_input:30938
> temp2_input:67735
> temp3_input:80000
> 
> On the host system "sensors" report
> 
> Package id 0:  +31.C (high = +80.C, crit = +90.C)
> 
> So I conclude Die temperature as retrieved over PECI is correct while
> DTS is mis-calculated. The old downstream code in OpenBMC was using
> ten_dot_six_to_millidegree() function for conversion, and that was
> providing expected results. And indeed if we reverse the calculation
> here we get 80000 - ((80000-67735) * 256 / 64) = 30940 which matches
> expectations.

-- 
With Best Regards,
Andy Shevchenko


