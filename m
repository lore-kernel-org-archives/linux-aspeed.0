From: Sudeep Holla <sudeep.holla@arm.com>
Date: Fri, 4 Aug 2023 10:51:27 +0100
Subject: [PATCH v2 17/23] firmware: Explicitly include correct DT includes
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-17-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
 <20230803-dt-header-cleanups-for-soc-v2-17-d8de2cc88bff@kernel.org>
Message-ID: <20230804095127.w74m6aphiwkaqlim@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 03, 2023 at 04:42:57PM -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/firmware/arm_scmi/driver.c | 4 ++--
>  drivers/firmware/scpi_pm_domain.c  | 3 ++-

(For SCMI changes)

Acked-by:  Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
