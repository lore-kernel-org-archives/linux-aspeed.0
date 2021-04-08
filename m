From: Joel Stanley <joel@jms.id.au>
Date: Thu, 8 Apr 2021 01:31:01 +0000
Subject: [PATCH 00/22] ARM: dts: aspeed: Updates for Rainier and Everest
 machines
In-Reply-To: <20210329150020.13632-1-eajames@linux.ibm.com>
References: <20210329150020.13632-1-eajames@linux.ibm.com>
Message-ID: <CACPK8Xdfuc1E8Rh=zgO6An+oJvikkDs_Ch1v0-v3rdC50WCZTA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 29 Mar 2021 at 15:00, Eddie James <eajames@linux.ibm.com> wrote:
>
> This series updates the device trees for the Rainier and Everest system
> BMCs. For Rainier, the changes have been tested fairly extensively in
> hardware. Everest has largely been tested in simulation and some basic
> hardware verification testing.

>   ARM: dts: aspeed: rainier: Support pass 2 planar

This patch does not build, suggesting it has not been tested. I fixed
it by adding the extra fan nodes that rainier was missing.

How about we support only the latest planar in the mainline tree, and
support for older versions can be carried in the downstream tree?

>   ARM: dts: Aspeed: Everest: Add max31785 fan controller device

This has been applied, but without the properties that are not upstream.

>   ARM: dts: aspeed: rainier: Add Operator Panel LEDs
>   ARM: dts: aspeed: rainier: Add leds that are off PCA9552
>   ARM: dts: aspeed: rainier: Add leds that are off pic16f882
>   ARM: dts: aspeed: rainier: Add leds on optional DASD cards
>   ARM: dts: aspeed: rainier: Add leds on optional PCI cable cards

These need to be re-worked to use the PCA driver directly instead of
exposing PCA LED devices as GPIO controllers and then attaching
gpio-leds to those GPIOs.

Country to previous concerns raised, there was no issue with "holes"
in the layout but instead a desire to avoid the "pca955x:" prefix in
sysfs. For now userspace will ignore that prefix when matching
devices. I also have a proposed patch to remove them:

https://lore.kernel.org/linux-leds/20210325005456.152469-1-joel at jms.id.au/

The changes I have merged have been pushed here. Please double check
that I've merged what you expected:

https://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git/log/?h=for-next

Cheers,

Joel
