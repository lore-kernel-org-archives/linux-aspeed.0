From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 1 Jul 2024 10:29:21 -0500
Subject: [PATCH v4 00/40] fsi: Add interrupt support
In-Reply-To: <21490f28ab110ae2eca59ec23591fc9c676361cc.camel@codeconstruct.com.au>
References: <20240605212312.349188-1-eajames@linux.ibm.com>
 <21490f28ab110ae2eca59ec23591fc9c676361cc.camel@codeconstruct.com.au>
Message-ID: <a242af91-5e7f-48e3-8445-46c4a8b6a4ef@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 6/5/24 20:02, Andrew Jeffery wrote:
> On Wed, 2024-06-05 at 16:22 -0500, Eddie James wrote:
>> Eddie James (40):
> ...
>
>>   .../dts/aspeed/aspeed-bmc-ibm-everest.dts     |  32 +-
>>   .../boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts |   1 +
>>   .../arm/boot/dts/aspeed/ibm-power10-dual.dtsi |  17 +-
>>   .../arm/boot/dts/aspeed/ibm-power10-quad.dtsi |  16 +-
>>   drivers/fsi/Kconfig                           |   2 +
>>   drivers/fsi/fsi-core.c                        | 888 +++++++++++++++---
>>   drivers/fsi/fsi-master-aspeed.c               | 431 +++++----
>>   drivers/fsi/fsi-master-hub.c                  | 244 ++---
>>   drivers/fsi/fsi-master-i2cr.c                 |   2 +-
>>   drivers/fsi/fsi-master.h                      |  33 +
>>   drivers/fsi/fsi-slave.h                       | 117 +++
>>   drivers/i2c/busses/i2c-fsi.c                  | 463 ++++++---
>>   drivers/spi/spi-fsi.c                         |  33 +-
>>   include/linux/fsi.h                           |   3 +
>>   include/trace/events/fsi.h                    | 171 ++--
>>   include/trace/events/fsi_master_aspeed.h      |  86 +-
>>   include/trace/events/i2c_fsi.h                |  45 +
>>   17 files changed, 1897 insertions(+), 687 deletions(-)
>>   create mode 100644 include/trace/events/i2c_fsi.h
>
> That's a lot of patches, that span the trees of several maintainers.
>
> What's your expectation for those who should be merging work in this
> combined series? Have you had any feedback in that regard?
>
> I'm asking because I need to make a call on what I do with respect to
> the Aspeed devicetrees. I think it would clarify responsibility if this
> series were split by subsystem. That way I can apply the devicetree
> patches and the rest can go through their respective trees.


OK, I'll go ahead and split this up, and probably just wait for the FSI 
changes to merge before sending other subsystems. Thanks for the 
guidance on merging!


Eddie



>
> If there are dependencies that require merging all or none, then it
> would be helpful if they were outlined in the cover letter. Even then,
> merging the leaves and waiting a cycle might make everyone's lives
> easier?
>
> Andrew
