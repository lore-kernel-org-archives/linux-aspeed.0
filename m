Return-Path: <linux-aspeed+bounces-4983-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A2BC88E5C
	for <linux-aspeed@archiver.kernel.org>; Mon, 14 Sep 2026 00:11:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjltl1bTmz2yQJ;
	Mon, 14 Sep 2026 10:11:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789279380;
	cv=none; b=PPez2YWzCivtvh0zs0t7UukbUVa8pOxCGXDor27UbGQ5ExHDR7c/xtboVpdPM2r0MQYcOmZ7vxEpEABO2Pyma2y2p4yI1G5oSK2NVMa2xc6bvLoD1h8jWJZ7L4TGe1hmi7dAhJS4C5DsrMwVrtPBFzE963YWFTV5I58T4XX7z85vfaMy475z3F9+5ZjjRa60E+c3SPXOEaeOXZ4D2LeVN0B+L9Cr61l6Gdt5DZdCmA9w+a+wVDGw6x/87wUFcNb3OPXmnhumya/5XQvXSwxp7LQkyg5aauKArkBEQYrEBbKwtQ+JwgJXbffbJkz7KO2HGJjHWO9tJfnEDkpRGWtJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789279380; c=relaxed/relaxed;
	bh=QgMX8CiibWPEaVVcLSm85/QfWicxIoxBAscuNI56DwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fa+aZpiJNFHOq/V6gO7zMZZvHyn2SKWgg/bXJoNQRLgoRAh+yfpNAkgk7+9yI0z7YL0VKOqr50e/I+RbSW7qxMyvMZYwXkMVfFngK6EqnLSQQl8Vcgu3H4P/lLyaTdkoq+4YIWuPPVod0S+U2/5JpRd0nRBz09eOk/AOeWBt9A12t4AoGzIBnCVLj7ja/CN5Mg5wq0wjtoLBJ6pxluue0O2bbCzCkNj7BHs0XVQ+AkY2e9Nan6OsTMXLSZ4FYYbPOCwyOXN+JwbukXP+0RAKh4W7POAm7Ax0bdGKWZK4LwAGJ+hY3cbwDEjawWhDC3ay3pzt38ZHmb0lnFcJCd0doQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QMFuiDw0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QMFuiDw0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjHkp1XKCz2xSg
	for <linux-aspeed@lists.ozlabs.org>; Sun, 13 Sep 2026 16:02:56 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2d747ed6d6eso5481025ad.2
        for <linux-aspeed@lists.ozlabs.org>; Sat, 12 Sep 2026 23:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789279374; x=1789884174; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QgMX8CiibWPEaVVcLSm85/QfWicxIoxBAscuNI56DwY=;
        b=QMFuiDw0q71I1QJGpIvDwImacgo/ciPQVV6Wc6oznis39HYpYoy1GJ/o+FilVpX69m
         gxeYVrwEdzYRk24Pux/LXAL/akrqhU3TqFSVXsCqcFMuSy/8LqBvRsVqSfCRdJ2FC5uH
         xbYxgMcTZhqSGJQ+d6JpcMGUyvXmBJg9MyU4vS5uhAO8TyzUEgQHjCpR7yt1aGR3hdbM
         5XVm8ZL74qlpNJ7oGeA8yCGHJ1RpfWmewfdwesULBgOj9qtK0vWmumLzF5es/EVcexkZ
         rybCWtQsO5PN+N/Mk9fIP2Snrwzlvg7vxQqgqhQ+Dqc+MruEPDkRo12hV4i0qTR5TNZL
         llNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789279374; x=1789884174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QgMX8CiibWPEaVVcLSm85/QfWicxIoxBAscuNI56DwY=;
        b=Vv96N6+AIjyVs2K+bu2hUy6VvsZVdiLNwcXlfWJ3YkduDXTwPhKGCibmA2PoQp4p+Z
         bD9hkh4ChTDCORYIs/BOJ6pwLtHrIsXqsKF8eKWsjUiVqs471fTqpiNmdlTMIoH/n0kr
         vxtcryV2oqKUt+F/BR7FyP67zMs1+zPhoFuzVfNyXibIMal5shHSwN7yP0WRy5ApbBQX
         IdGklbXmQ2aD8qJX282IqHbZ54ejHcyUo1q/4arSxjpYWfj4Y5g8vdKwsPCKahJSytoR
         JzahZtwJ/cSHSWphNFcCXlKHqwMgaxcTrVBKtfi2lY1AcfSmS67W3ujGALHHP4fuyMcx
         Qsiw==
X-Forwarded-Encrypted: i=1; AKwUvBwupUyD3XLTD51W8qsjEcqA7XRhVs0R6ih8uCxe4TSii4Oa3ZWEopQWN2epqsxDHal8MP8RjnxE3RVArbw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++llhuwgMnQOYNOvp4sNU3XVtfwq0QgZ63G3Aw2/uDL5vBfm/kAD
	hOg4wbl5uyDaG8YjClE4oMqbXGUyOUISKDf2I+DFXWrOoyzT0BrSPGIP
X-Gm-Gg: AYBFou2qF5C2ClNf/2c2Es16s7slCqfycZ0fkQaY7qN296nogd3EGCIFSvWIu9ZUEkj
	JdDZ8wEVhlpSS75t7UpOFfX61TdsMM6x6h9V6En9YE3OF8qoqTz/DliOr8aKO//VE8+2L+cVP8+
	A/+0YYQJ/9VNxEpiATWe2j4Fok7Vatpf8uOirK03nCJs7oo5ZWVRPKTaHaVb+TOPEhsXo/TZEOV
	X92eSw9ngSUN0vE7RgbzSb+ulZMyINsKnXIsCZW3DUuMeWXQZWdbFG/Qsx0VysvLB2K2QEF/pHU
	xkhmPrwWpreV2OHiQpOv6TRRcFB6lor0oKc7ruYul4i4wDDVxvyJt1TLDbwPMa8mH3ILA1G5w08
	brZNGat/3dzkPBTT8cs1F4D43qBoQZdEu7gq+XAzseW3rap4M5tIcKCtEWiOd8/1psSXepqfEZ8
	S/dFlgC0UgGVK9TYjFci4AB6HO8UAcXb5JlOzdAyr6p5UrXK8fv+hvyw==
X-Received: by 2002:a17:902:c947:b0:2d8:d4d3:3fc0 with SMTP id d9443c01a7336-2dd4bdaf9bfmr98050145ad.20.1789279374119;
        Sat, 12 Sep 2026 23:02:54 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd3f0faf19sm23811575ad.12.2026.09.12.23.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 23:02:53 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Eddie James <eajames@linux.ibm.com>,
	Ninad Palsule <ninad@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Alistair Popple <alistair@popple.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsi@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fsi: aspeed: fix memory leak on remove
Date: Sun, 13 Sep 2026 14:02:42 +0800
Message-ID: <20260913060242.1426845-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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
Content-Transfer-Encoding: 8bit

fsi_master_aspeed_probe() takes an extra reference to master.dev with
get_device() after registering the FSI master so that the aspeed object
remains valid while the remove path performs its cleanup.

However, fsi_master_aspeed_remove() never drops this extra reference.
After fsi_master_unregister() releases the reference held by device
registration, the extra reference remains and prevents the device
release callback from being invoked. As a result,
aspeed_master_release() is never called and the fsi_master_aspeed
object is leaked.

Drop the extra device reference with put_device() after the clock has
been disabled. This allows the reference count to reach zero and
aspeed_master_release() to free the aspeed object.

This issue was found by manual code inspection.

Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/fsi/fsi-master-aspeed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index aa1380cdff33..d21d06b44350 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -652,6 +652,7 @@ static void fsi_master_aspeed_remove(struct platform_device *pdev)
 
 	fsi_master_unregister(&aspeed->master);
 	clk_disable_unprepare(aspeed->clk);
+	put_device(&aspeed->master.dev);
 }
 
 static const struct of_device_id fsi_master_aspeed_match[] = {
-- 
2.43.0


