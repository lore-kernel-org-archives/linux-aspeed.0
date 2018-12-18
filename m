From: Sasha Levin <sashal@kernel.org>
Date: Mon, 17 Dec 2018 19:20:28 -0500
Subject: [PATCH 0/7] v4.19-stable randconfig fixes
In-Reply-To: <20181214221023.3878670-1-arnd@arndb.de>
References: <20181214221023.3878670-1-arnd@arndb.de>
Message-ID: <20181218002028.GX2746@sasha-vm>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 14, 2018 at 11:10:05PM +0100, Arnd Bergmann wrote:
>Hi Greg,
>
>I did some randconfig testing on linux-4.19 arm/arm64/x86. So far I needed
>27 patches, most of which are also still needed in mainline Linux. I
>had submitted some before, and others were not submitted previously
>for some reason. I'll try to get those fixed in mainline and then
>make sure we get them into 4.19 as well.
>
>This series for now contains four patches that did make it into mainline:
>
>2e6ae11dd0d1 ("slimbus: ngd: mark PM functions as __maybe_unused")
>33f49571d750 ("staging: olpc_dcon: add a missing dependency")
>0eeec01488da ("scsi: raid_attrs: fix unused variable warning")
>11d4afd4ff66 ("sched/pelt: Fix warning and clean up IRQ PELT config")
>
>Feel free to either cherry-pick those from mainline or apply the
>patch from this series, whichever works best for you.
>
>The other three patches are for warnings in code that got removed in
>mainline kernels:
>
>3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events properly")
>972910948fb6 ("ARM: dts: qcom: Remove Arrow SD600 eval board")
>effec874792f ("drm/msm/dpu: Remove dpu_dbg")
>
>My feeling was that it's safer to just address the warning by fixing
>the code correctly in each of these cases, but if you disagree,
>applying the mainline change should work equally well, so decide
>for yourself.

Thanks Arnd, I took the series as is.

We really need to discuss how -stable deals with removed code upstream.
For some cases, we should probably follow suit and remove it from
-stable as well (I'm mostly thinking dodgy code with potential security
issues).

--
Thanks,
Sasha
