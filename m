From: Winiarska, Iwona <iwona.winiarska@intel.com>
Date: Tue, 8 Feb 2022 14:48:45 +0000
Subject: [PATCH v7 07/13] peci: Add sysfs interface for PECI bus
In-Reply-To: <YgJPFlr18AmWiTRY@kroah.com>
References: <20220202144838.163875-1-iwona.winiarska@intel.com>
 <20220202144838.163875-8-iwona.winiarska@intel.com>
 <YgJPFlr18AmWiTRY@kroah.com>
Message-ID: <4892938763614967ba8b0f428afc1bc734f8f0b5.camel@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2022-02-08 at 12:08 +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 02, 2022 at 03:48:32PM +0100, Iwona Winiarska wrote:
> > PECI devices may not be discoverable at the time when PECI controller is
> > being added (e.g. BMC can boot up when the Host system is still in S5).
> > Since we currently don't have the capabilities to figure out the Host
> > system state inside the PECI subsystem itself, we have to rely on
> > userspace to do it for us.
> > 
> > In the future, PECI subsystem may be expanded with mechanisms that allow
> > us to avoid depending on userspace interaction (e.g. CPU presence could
> > be detected using GPIO, and the information on whether it's discoverable
> > could be obtained over IPMI).
> > Unfortunately, those methods may ultimately not be available (support
> > will vary from platform to platform), which means that we still need
> > platform independent method triggered by userspace.
> > 
> > Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> > ---
> > ?Documentation/ABI/testing/sysfs-bus-peci | 16 +++++
> > ?drivers/peci/Makefile??????????????????? |? 2 +-
> > ?drivers/peci/core.c????????????????????? |? 3 +-
> > ?drivers/peci/device.c??????????????????? |? 1 +
> > ?drivers/peci/internal.h????????????????? |? 5 ++
> > ?drivers/peci/sysfs.c???????????????????? | 82 ++++++++++++++++++++++++
> > ?6 files changed, 107 insertions(+), 2 deletions(-)
> > ?create mode 100644 Documentation/ABI/testing/sysfs-bus-peci
> > ?create mode 100644 drivers/peci/sysfs.c
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-peci
> > b/Documentation/ABI/testing/sysfs-bus-peci
> > new file mode 100644
> > index 000000000000..56c2b2216bbd
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-peci
> > @@ -0,0 +1,16 @@
> > +What:??????????/sys/bus/peci/rescan
> > +Date:??????????July 2021
> > +KernelVersion:?5.15
> 
> 5.15 was a long time ago :(
> 
> 
> Other than this nit, these all look semi-sane to me.? What tree are you
> wanting these to go through, mine?? If so, can you fix this up (both
> places in this file) and resend?

Thank you! Yes, it would be great if it can go through your tree.
I'll send v8 with fixes.

Thanks
-Iwona

> 
> thanks,
> 
> greg k-h

