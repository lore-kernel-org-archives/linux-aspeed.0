From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 15 Jul 2023 09:55:38 -0700
Subject: [PATCH] hwmon: Explicitly include correct DT includes
In-Reply-To: <20230714174607.4057185-1-robh@kernel.org>
References: <20230714174607.4057185-1-robh@kernel.org>
Message-ID: <e0e1b465-8419-419e-90ae-4b72f5189469@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 14, 2023 at 11:46:04AM -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter
