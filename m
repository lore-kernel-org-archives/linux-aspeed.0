Return-Path: <linux-aspeed+bounces-3518-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263E6EF99EB
	for <linux-aspeed@archiver.kernel.org>; Sat, 14 Feb 2026 01:05:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fCW715pJ8z2xln;
	Sat, 14 Feb 2026 12:05:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771031133;
	cv=none; b=DrQlJw1984JkQ3c8XppRhIGgFb/+THA1oA+vSTJYfQdcUCntUfnQpT9fRCFUMy2Yk8wSn9zmqnwcJBImFkkdabMnj30H1bt0PUUBgvqZTJvP+iMtCqSLN9wXkG4cGIfDbJtsAw1BLBqN6WleA59wNaPCTye4H/rjbmDWBuWwOXZTK772pjWZl9PIADC+NPylT4/q0bKHJVQp0ymyr03QQahzIT89hze+UydDJRk6Uhu2bNsisk5yAK7iDiTQ4pDQ7kEkNjUYGUe3DvZZzW9X3ndq0t9AF/gi4B3EL06t4O0w1FjOWEqHcoD/CYMjNQwUyf0H86Pj7zdqREgCPPFHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771031133; c=relaxed/relaxed;
	bh=/w/NFw1D6JmYMGD/vnJu03M8SHvvtLm/FNBH+/7eS3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfmOWNtJc2RzlJ8AzGVGQFayKhtHoKJP+OH6s0fn6nn1e5QWQxptoLF3rs8C2FCzrmEc9dzhVqEHSJqnaT2V0twgza1YQyik/zRwlKq5ObY8yCnl0gHTAbEgU+sSQUBmKd5J1BSTqS7d88xzd3O/FQvVtZJo60AMNX73wIxL9N4PjFju+TIqogEhSHYvxtd7fLDHlcCZ+7quG/z6jV8Kyagh73mPrisHcIxPnRsPcFXlRzqrpgnVIHLP2Fb5N9XX/cr7l68f6zq2MIugn9U8iMhE3O2FjMi2eq+jUTlAcCYYylzeV4aRMZhGJcN/qiLoLtRDENbrI/1uzpa5TAGzFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Mnd8Lv+N; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Mnd8Lv+N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fCW710z1tz2xSF
	for <linux-aspeed@lists.ozlabs.org>; Sat, 14 Feb 2026 12:05:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 05FBE44371;
	Sat, 14 Feb 2026 01:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA1BC19423;
	Sat, 14 Feb 2026 01:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771031130;
	bh=eBEsX1nyMrmXr/mfibb4cH9Xymd5V8ShqLBPnfWpmSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mnd8Lv+N72Pmpoq651k8GlpYaoE2hKL3IGdboT5PF608kwKOJd6WDBhASZnSAivX7
	 +JrMZ3Dlxg3lPWuhtRBIQNauBvsBxX2stLMHw+pGG/UPhM6u+bdYz8JzqxziDh64qY
	 zB5woGl9DJyCICmIchFYGbrpGaqXqi+KIIPIY64u3syO7Gp2H0g5vQK4zzuA0In05C
	 ALiRD42rOAV1ZazFP6cR+u0pL074k3844/D7g+Ynb4SfWVITQa04mTrpUjogL0I+N0
	 LRpKCH095zdZKo/z+YzVMk05PObxi9Qt5Hboci4jpFNVEJEei3LS9ML+anSRPk3XmR
	 M7aRbjwWxG/Yw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Billy Tsai <billy_tsai@aspeedtech.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	brgl@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.19-5.10] gpio: aspeed-sgpio: Change the macro to support deferred probe
Date: Fri, 13 Feb 2026 19:59:14 -0500
Message-ID: <20260214010245.3671907-74-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214010245.3671907-1-sashal@kernel.org>
References: <20260214010245.3671907-1-sashal@kernel.org>
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Billy Tsai <billy_tsai@aspeedtech.com>

[ Upstream commit e18533b023ec7a33488bcf33140ce69bbba2894f ]

Use module_platform_driver() to replace module_platform_driver_probe().
The former utilizes platform_driver_register(), which allows the driver to
defer probing when it doesn't acquire the necessary resources due to probe
order. In contrast, the latter uses __platform_driver_probe(), which
includes the comment "Note that this is incompatible with deferred
probing." Since our SGPIO driver requires access to the clock resource, the
former is more suitable.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Link: https://lore.kernel.org/r/20260123-upstream_sgpio-v2-1-69cfd1631400@aspeedtech.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis of gpio: aspeed-sgpio: Change the macro to support deferred
probe

### Commit Message Analysis

The commit changes `module_platform_driver_probe()` to
`module_platform_driver()` in the Aspeed SGPIO driver. The motivation is
to support deferred probing — when the clock resource isn't available
yet at probe time due to probe ordering, the driver should be able to
defer and retry later. With `module_platform_driver_probe()` (which uses
`__platform_driver_probe()`), deferred probing is explicitly not
supported.

### Code Change Analysis

The changes are:

1. **Remove `__init` annotation** from `aspeed_sgpio_probe()` —
   necessary because with `module_platform_driver()`, the probe function
   can be called after init (during deferred probe), so it can't be in
   `.init` section.

2. **Move `.probe` into the `platform_driver` struct** — from being
   passed as a second argument to `module_platform_driver_probe()` to
   being set as `.probe = aspeed_sgpio_probe` in the struct.

3. **Replace `module_platform_driver_probe()` with
   `module_platform_driver()`** — the actual behavioral change.

The probe function itself is completely unchanged in logic.

### Bug Classification

This fixes a **real probe failure bug**. When the Aspeed SGPIO driver is
compiled and the clock resource it depends on isn't yet available
(common on device-tree platforms where probe order isn't guaranteed),
the driver will fail to probe and **never retry**. This means the SGPIO
hardware is permanently non-functional until reboot, and even then only
if probe order happens to be favorable.

This is a real-world issue on Aspeed BMC platforms (AST2400, AST2500,
AST2600) which are widely used in server management. GPIO functionality
being unavailable due to probe ordering is a tangible user-facing bug.

### Scope and Risk Assessment

- **Lines changed**: Very small — removal of `__init`, moving the
  `.probe` assignment, macro swap
- **Files touched**: 1 file
- **Risk**: Very low. The probe function logic is completely unchanged.
  The only behavioral difference is that:
  1. The probe function is no longer in `.init` section (minor memory
     impact, but standard practice)
  2. Deferred probing is now supported (fixes the bug)
  3. The probe function pointer is stored in the driver struct rather
     than being patched in at registration time

This is a well-understood pattern — many drivers have made this exact
same transition over the years. The `module_platform_driver_probe()` to
`module_platform_driver()` conversion is one of the most common and
safest changes in the kernel.

### Stable Criteria Check

1. **Obviously correct and tested**: Yes — reviewed by Linus Walleij
   (GPIO subsystem co-maintainer), standard pattern
2. **Fixes a real bug**: Yes — probe failure when clock resource isn't
   available due to ordering
3. **Important issue**: Moderate — makes hardware permanently non-
   functional on affected platforms
4. **Small and contained**: Yes — minimal changes to one file
5. **No new features**: Correct — deferred probing is an existing kernel
   mechanism, this just enables the driver to participate in it
6. **Applies cleanly**: Should apply cleanly to any stable tree that has
   this driver

### User Impact

Aspeed BMC platforms are common in enterprise server management
(OpenBMC). If SGPIO fails to probe due to clock resource ordering, GPIO
pins managed by the SGPIO controller become unavailable, which can
affect system monitoring, power control, and other BMC functions. This
is a real-world issue that affects actual deployments.

### Concerns

- The commit doesn't have a `Fixes:` tag, which is expected for commits
  under review
- No explicit mention of user reports, but the commit author is from
  Aspeed Technology, indicating this is a known issue in their platform
- Minor: probe function no longer freed after init, but this is
  negligible memory impact

### Decision

This is a small, well-understood fix for a real probe failure bug on
Aspeed BMC platforms. The pattern change (`module_platform_driver_probe`
→ `module_platform_driver`) is one of the safest and most common
conversions in the kernel. It fixes a real-world issue where hardware
becomes non-functional due to probe ordering. The risk is minimal and
the benefit is clear.

**YES**

 drivers/gpio/gpio-aspeed-sgpio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index 7622f9e9f54af..318cd0e397416 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -516,7 +516,7 @@ static const struct of_device_id aspeed_sgpio_of_table[] = {
 
 MODULE_DEVICE_TABLE(of, aspeed_sgpio_of_table);
 
-static int __init aspeed_sgpio_probe(struct platform_device *pdev)
+static int aspeed_sgpio_probe(struct platform_device *pdev)
 {
 	u32 nr_gpios, sgpio_freq, sgpio_clk_div, gpio_cnt_regval, pin_mask;
 	const struct aspeed_sgpio_pdata *pdata;
@@ -611,11 +611,12 @@ static int __init aspeed_sgpio_probe(struct platform_device *pdev)
 }
 
 static struct platform_driver aspeed_sgpio_driver = {
+	.probe = aspeed_sgpio_probe,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = aspeed_sgpio_of_table,
 	},
 };
 
-module_platform_driver_probe(aspeed_sgpio_driver, aspeed_sgpio_probe);
+module_platform_driver(aspeed_sgpio_driver);
 MODULE_DESCRIPTION("Aspeed Serial GPIO Driver");
-- 
2.51.0


