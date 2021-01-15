From: Paul Fertser <fercerpav@gmail.com>
Date: Fri, 15 Jan 2021 13:46:35 +0300
Subject: [PATCH v29 0/6] JTAG driver introduction
In-Reply-To: <20200413222920.4722-1-ernesto.corona@intel.com>
References: <20200413222920.4722-1-ernesto.corona@intel.com>
Message-ID: <20210115104635.GA2971@home.paul.comp>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This is a multi-part review of the series, with general notes inline
in this message, and specific points raised as replies to the
individual patches.

On Mon, Apr 13, 2020 at 03:29:14PM -0700, Ernesto Corona wrote:
> We propose to implement general JTAG interface and infrastructure
> to communicate with user layer application.

Working with a Tioga Pass server platform I needed to use the JTAG
master controller of an ASPEED AST2500 SoC to configure a Lattice
LCMXO2-4000HC CPLD. I'm mentioning these fine details because that's
the only proper runtime testing I performed, but my review is not
limited to that.

Being a long-time OpenOCD community member, I got familiar with many
different facilities and protocols offered by hardware JTAG adapters,
and of wide range of usecases as I was providing end-user
support. This is my perspective when looking at these patches.

I have to note that the current v29 version of the series is broken in
several aspects:

1. The aspeed driver fails probe(), see the driver review for details;

2. The uapi include header is unusable;

3. The offered userspace implementation wasn't updated to the latest
API, but even with the changes to make it compile it's still a mess
too horrible to be used in production;

Points 1 and 2 will be addressed in separate mails. To workaround
point 3 I prepared a recipe with an additional patch[0] so that
mlnx_cpldprog can be at least compiled and used for some minimal
testing.

The shortcomings of mlnx_cpldprog are numerous:

1. It doesn't consistently choose between hardware and bitbang modes;

2. Even though it checks TDO it doesn't print any errors on mismatch
and continues playing back the SVF as if it's all right;

3. It has JTAG speed hardcoded;

4. It doesn't implement RUNTEST so with the CPLD I'm using it's always
_not_ working properly, failing silently;

5. It is just awfully slow, taking about 40 minutes to play back a
file that takes 1.5 minutes with OpenOCD with the same hardware and
kernel driver.

So I added support for the proposed API to OpenOCD: patch that applies
to the version in OpenBMC[1], patch for the latest version[2]. And
since it can do much more than just playing back SVF I hope this can
highlight some essential API shortcomings if it's meant to be
generic. My impression is that in its current state it's not adequate
for the purpose.

[0] https://bitbucket.org/paulfertser/mlnx_cpldprog_bitbake
[1] http://openocd.zylin.com/#/c/5976/
[2] http://openocd.zylin.com/#/c/5975/
-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav at gmail.com
