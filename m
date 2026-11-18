Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4D160A6F62
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Nov 2026 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ibs2CC+D
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVGfW54CHz2yQn;
	Thu, 19 Nov 2026 09:36:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795015199;
	cv=none; b=XamkGi46W1+nGT/JyBjvGKQpEblzdyf1Oxx+09x/tZJpfAA3HJLwKA/Mh65ATCCyqVJf3NG9tsbfJtqBjjRu8R3k+nwVn/2pLsuindIGDz1eaFez+xRts8rKNrrvvsQ1IDkytg87uSEXFSksZ8qc1cDQrghnunZikJ6+2EsCpJVGSSH7LD2sQ4ObaPf93NohTXCeM3h49ossAEmbatPqiNy7MrEKdtgBPbR7nRTYh1fX3GXpH81PjSBPEkaJIZPmAcZ8BIrOE9D7wPe9QkhLMrn6E79FiG9RenKer4NwqAYoJdOzT+hocnP9ASI3Qf1iNraPdPpDXn3Fba3lkUR6Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795015199; c=relaxed/relaxed;
	bh=3q3WBayPBlbewt1E1eNRkQsJMusptNxG4L6m1LCm1Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GZtv1b3H8yg2wyPnRKtqkvCbbY2eqmqfm/sgRuS6g1iHomOgSPsj99s+a8sprlkSrN+2LlPC+/ORZ19kUEW1GReet/Rb7EjEj/EMNWICeVGH2zbeo2MHUSxfC9Jj/rP7XrwhgnY67vzWH+ps3DOSeSlvJt1XnKD1ToqfK2XtQAlepaff2hJFaP28nSkGKwfU//omhtGNsRjY4KGJoeoTDn2Z1fLNAPWmRHdSMKuDVvJ/X3cLHx59yr26FSd7R0E6gH8du6Q4Dn/csphuJdCTxB1FbEUK1xQDuo/5LhW5lRaZotAEATNTKpKhPkyVrv2I3kwixIHaamZ/4BVa12e0wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ibs2CC+D; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=ericyunlinchiang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ibs2CC+D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=ericyunlinchiang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV4z24Bq3z2xMt
	for <linux-aspeed@lists.ozlabs.org>; Thu, 19 Nov 2026 02:19:57 +1100 (AEDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso908341a12.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Nov 2026 07:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795015195; x=1795619995; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3q3WBayPBlbewt1E1eNRkQsJMusptNxG4L6m1LCm1Ic=;
        b=Ibs2CC+D/4g8uWrkw25OWfMcz6I8x+yVNjX7OGYFiqLQN34d73fRgtuPkQB/ZbVkQM
         7HVgcOY/cp3XmB5zHuHm7IIXcPDt1OrOfeUMdfHadPqHME9HopN2m5cvCQ4VkGQqoqxh
         oVECDWNOplyKPrjB2kYJrwvfKNdveSwNRV3bjJ36D3zoJ1g3y1J13mfsF1rjfmx0cY4+
         /wJnl6o/yiiV+PrbkUXmiQZL8pp7ktDQcJZT7q4te9tNa54wArQx0Pmo1NXIpzlCU6ct
         nQiaME7He30mq4PYQ8KCDTSzB8GvgGhMaTpUUovl6q44R9K7dKeWiCtZM2GhIFA0DNOT
         CRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795015195; x=1795619995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3q3WBayPBlbewt1E1eNRkQsJMusptNxG4L6m1LCm1Ic=;
        b=Ao8JMqgntVh76qWe/Ejsbf+Iqml6igNNCC9C0PV859ysYSVsWzSl+03MycAnw+H/79
         doE4Vajn3g6/roPnYFQh/gyxviaBuvY0/0uN2Fedaku0KVAL0q2vXXvj5eaigLEwYwGs
         JUt8hLgOGTFnIMl20qXWG18JKEvixNhVOkNCkZd+GoUQwd7Ks2iybZ9Um9u4q1b5WVWc
         mBDwDDY/y0Iqx5fhsYsJhG07+U47Kv0iSi4UW5BU2tWyHWq02vxTAf03J7ejdm4J0jIb
         xafZ4oREW5ubVjm9JL72rQaAm2c4TTJYIp8nGD/HwxB6144uzX3/d0D22TuwGkVjmCWr
         pNaQ==
X-Forwarded-Encrypted: i=1; AL+hErHtWkI6Dt4jf7dULfSB9NovvZtFCgnkG7qKkxpzZCWYibtmNjP15Rq+FEfLD0r8POOVxd9N1hlKLpZ/FW4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/tXjLxgEKvmepyVOpPAGFBxXvVOkSbnY3mGtLQ1ks2L1lsQnZ/
	D1hw87FgoOFSMb7jPLwy5WJxsSy6eDFNk/KM/dYQ6kBsLDaamYIYtoC+
X-Gm-Gg: AYBFou0ecc3dU+8o6W11RYaNIbM1yOMb2lSl04sgdRjAXoredmHnwqEA/m+rgySnKd+
	lauIdvFsvfe6j9alLtLXc+zusuzM8SGdbD6D9QptRHPMAYYSn5hk1OIxsc5M0MwSXccMXn8GcbD
	MDPqehQ9X47AMg5cxBv43gLiLf2t6Strf3wlRbQBvyfG8W13IbFcb1R3eTynhC3EZtDUWOqX9Lb
	BnQdGMJWd5knhBr+shPoyKIe5NNaOYsbsUlw/fCLWrpeC9UwgbWcGmljBqtnzaQjs7HLFyLOy7r
	c8PBocb/kOM4RPBCzVBbT5yDvJSRmWcTCARmrh879gWfCEBE8lyC4REhjaVP9bxH6a3ymJo63Sc
	KmMa0nOkb7x7YlN5clpKokV2swlx64o0DHxoHoGC1D1RxZ7F/P1qFOlG9ETo9HvursdJsOAvm8t
	rJXvV90Di/9J992/s91UWe5X6aEWebXDVAHGujXpXqgP/kOA2ZM0tQT7lMDXp1SSeufQj0wDXzn
	cammsyjn42WlyQwxnKH5NHdlmuYeU1zFrAVAGWM3ae6O5eMp5c8bdiJ5lx+1d1UXXOtdx/Qk8HP
	+55G3LAQiES0YP+RkzBm0WsHgPTEUJKMzUore0kstqBtmYrg+9WNU7YXw1mDxrU+H80I9g==
X-Received: by 2002:a05:6a21:32a2:b0:3eb:98d2:cd89 with SMTP id adf61e73a8af0-3fe892fd694mr3439498637.25.1795015194581;
        Wed, 18 Nov 2026 07:19:54 -0800 (PST)
Received: from eric-N-A (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5ca7aa27dsm1408559b3a.19.2026.11.18.07.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:19:54 -0800 (PST)
From: Eric Yun Lin Chiang <ericyunlinchiang@gmail.com>
To: Stefan Schaeckeler <sschaeck@cisco.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	linux-edac@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Eric Yun Lin Chiang <ericyunlinchiang@gmail.com>
Subject: [PATCH] EDAC/aspeed: do not fail probe when ECC is disabled
Date: Wed, 18 Nov 2026 23:19:07 +0800
Message-ID: <20261118151907.3949719-1-ericyunlinchiang@gmail.com>
X-Mailer: git-send-email 2.53.0
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AST2600 memory-controller EDAC node is enabled by default in
aspeed-g6.dtsi (it has no status property), so aspeed_edac binds on
every AST2600 board. aspeed_probe() reads the memory-controller
configuration and, when DRAM ECC was not turned on by firmware,
prints an error and returns -EPERM:

  aspeed-edac 1e6e0000.sdram: ECC mode is not configured in u-boot
  aspeed-edac 1e6e0000.sdram: probe with driver aspeed-edac failed with error -1

Running without DRAM ECC is a normal platform choice, not a failure.
-EPERM is both the wrong errno (this is not a permission problem) and
one the driver core reports as a probe error, so every non-ECC AST2600
board logs a spurious "failed with error -1" at boot.

Return -ENODEV instead, which the driver core treats as "no device to
bind" and does not log as an error, and lower the message to dev_info so
the reason EDAC did not register is still visible once without looking
like a fault. The AST2500 node is disabled by default, so only boards
that explicitly enable it are affected there. No other error path is
changed.

This change was prepared with the help of an AI coding assistant, which
analysed the probe path and drafted this changelog; the author has
reviewed it and stands behind the change.

Fixes: 9b7e6242ee4e ("EDAC, aspeed: Add an Aspeed AST2500 EDAC driver")
Signed-off-by: Eric Yun Lin Chiang <ericyunlinchiang@gmail.com>
---
Tested: the pre-fix "failed with error -1" was reproduced on an AST2600
(Facebook Bletchley) BMC by triggering the aspeed-edac probe over sysfs;
the fixed driver builds (W=1, no new warnings) and passes checkpatch,
and the resulting behaviour -- aspeed_probe() now returns -ENODEV, which
the driver core does not log as an error -- was confirmed by disassembly
of the built object. NOT boot-tested on hardware (the kernel was not
booted).

 drivers/edac/aspeed_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index 6e069b255..e6f8cf78a 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -295,8 +295,8 @@ static int aspeed_probe(struct platform_device *pdev)
 	/* bail out if ECC mode is not configured */
 	regmap_read(aspeed_regmap, ASPEED_MCR_CONF, &reg04);
 	if (!(reg04 & ASPEED_MCR_CONF_ECC)) {
-		dev_err(&pdev->dev, "ECC mode is not configured in u-boot\n");
-		return -EPERM;
+		dev_info(&pdev->dev, "ECC mode is not configured in u-boot\n");
+		return -ENODEV;
 	}
 
 	edac_op_state = EDAC_OPSTATE_INT;
-- 
2.53.0


