Return-Path: <linux-aspeed+bounces-4664-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8F2C5AD5A
	for <linux-aspeed@archiver.kernel.org>; Sun,  9 Aug 2026 03:01:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHjM614yCz2y1Y;
	Sun, 09 Aug 2026 13:01:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786090635;
	cv=none; b=Ky1ec62UUH6iQRyE4lrBtoKBqCmsHhDzYxANQqwnwE2X3XvZr/OTAT5zgKT9awcSI2xQgiEmTzXDqcogrUXE1poNQ/W1kTDmI6q8My/f3OT+bIRR1a74Olvdfkt52DxQME/juo9h3QRBNWzmI7ffJpHrlnRc0OJSb3ft7dT2yQ7PlbcPrzLTYx9uvAOR+ECDbcjEHEGHUCvnwRcWcGTv+7k6GqS3AbWsHzH+vp1xOhUIePvPX80l1VAJeKYBWCDYjjXtowHflQHDtMCo972MkJf0O0rrEjMXypRabufbK231RWPENxYwkKb5dZT7hR6wrbDK6e5JGj71xYVUX1zt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786090635; c=relaxed/relaxed;
	bh=Og8epPMT2luMUJBXRpFI2/AU8UKubYJ4m2A5JNHJ56Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYnikhn7htH0cYbokGox5AdRWa705z++Qv7p126Ls67tQ5yQBQmAhO9WjAw89zshlbCtGg9A4M3yhHeWVB/qNDqIsiN3lDf5GdCne6lemR3gAo2kYhmI6fTHnSIs6rBk/bEvxd5RcOTRi+ItqWkiTcht8i5EzpD61FW/qeM7/Cf2t3Llwu8iPgxrn2kRHh85+jPqJcFtbu6ldE3H1yzUZtXNbu6cO1zSkwtMQcIFc0eCaKub+RAccWnHWxhQb4wdX3ZATXLf9GoMzzpV+eri35oCdUpMMxnezeW1LTl2pvqVX9PpjDd8RRyg3LlRJWF3PniRsEHqnxtRTw/Y9R8XlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hFU9oAfJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hFU9oAfJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGcSm2shqz3bps
	for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 18:17:11 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so2572575a91.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 01:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786090628; x=1786695428; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Og8epPMT2luMUJBXRpFI2/AU8UKubYJ4m2A5JNHJ56Y=;
        b=hFU9oAfJ4P3Jb3Anb7KLRlLn3hHocd7uiVyO/vA+2KbVBX5t0RnKAYxMmkncSKPt3C
         mDX0Xl/0lgSvKg5ZgHLUzAiZfDHJezMeDQYxKEsY83sp0KmWIu6dWQtYPhpzhNmMI8Gr
         U5B6xLFXatjOoSRMLSOKU8N0bFcf8k2y4+HLoAyayP+UgvgN0yzNqkNPIgPMeTHv7Vcw
         Ab7j47o1O167z/HN5nFH1Y47Y3Dd9Podi4p92V/0eUOTknPz+6k6LLr6aBT1MpflALT5
         vuzI63Be6J3xmrjkzF1dj99Mr9n7U/n+JAU/oylW3jLZlSrb991vlqT4kG96MVL6aAP3
         89BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786090628; x=1786695428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Og8epPMT2luMUJBXRpFI2/AU8UKubYJ4m2A5JNHJ56Y=;
        b=nlcrXtMsbwa0tGo4GSV+LNVXTphCTZFDx6wnGrmBUa2DoehR0v5GuqIMhCLTFslB3o
         hvH9l9Io4VwKq5LzimxGNMvLdVzdaMoEJwrzLDGpnBij933kGV15DcBkbQCIQlG6X/Hc
         3zOXFGhiICiV6vz4Fju0Ls9a7upUj6QGxMAqshJ5imT34SGmJAJM5eMMjjRd4KPpL58B
         xeIle5h2s65i/nM3DTm94rSIpzGyI3tYfyvccSCeReBWO36Di+DWHtFZyTH/rShVRLFl
         fFydcsd1psYLV/psn9NLt7TFhUqexNY+IEn6RUF7VjL5pw2Ql3U/gMn7fuuGTE4UnaYe
         gD6w==
X-Forwarded-Encrypted: i=1; AHgh+RpIXlLOq7G6xmMIa+9XpIpS9AcaBYvieLpYXrHF0oYSebZfyi2PPPryGY7YjcWao2+UDVp9mxluzx/t2V4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx7PEwttEJiwsWRZ90RQfgea/LykePnjsCiSv0S/7+zngAC6Ve9
	N4Roip/uDxeoQCl17yhsrJMV09SZ245vo8F5iD5thSgKYfL6jY149hke
X-Gm-Gg: AR+sD10ryQjTEpaX+cjrNZQErErdDUJTUNuCsgCDf9XaYMvkGWwZOeBSuJFEB2Z8rhJ
	K3pkyuPat+4f0aN2k5BFLa7vEBkSF16adVpYGVhqNSsMtBsSjMfldtRctK+0mSQUiHO1s4OClhn
	FnjpmSINOcqBIKyQuGiM/g5PfjAdboReyoDkAyh1yA6cEsSuQkOtiQ4OXexJkcpOWGqEKG6w1+I
	2VI3FOPiRXJDakFrKGbkucFWGnrrvW5DxxuZzVjufE7DgorQIEfUG57ii4UNL2OvmFfnv56XT9c
	9FqFjFBanuCHHPXVOfeuHLpvAPsVq0smQxOqKkgF1/mPqxlw9yZwqtgkvRJepA2Ghj307xLf3+u
	FhVm2YgxbB4G4I0Ni4XGg9pJXNh4Htfxf/NZEzkIPZee5T/aEFil8Dv8qviM79hV/QQ5LXSrLBv
	vI7j2RvVOh9H0hlgEI5vdgHzrPQiiwa4JIMBOxC2lqx90nkBhFii+MJ3M9Q6rQgFnD/gsPbrkSR
	ZdZie1LBSMQXDA74+0kg5nAJmeuNuD/O17xproHCnUmlWX6j8Z8gZ99sz1+cR6BRCOovAN7XoSY
	gUTtxn7YnIRnxjU=
X-Received: by 2002:a17:90b:51ca:b0:38e:5b59:c2ff with SMTP id 98e67ed59e1d1-3909d79f8f5mr8625493a91.3.1786090627565;
        Fri, 07 Aug 2026 01:17:07 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de8ddcsm3913377a91.6.2026.08.07.01.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:17:07 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 1/4] watchdog: qcom: Propagate errors from optional IRQ lookup
Date: Fri,  7 Aug 2026 15:16:49 +0700
Message-ID: <20260807081652.38692-1-phucduc.bui@gmail.com>
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

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no IRQ is available, while other errors should be propagated.

Instead of only checking for -EPROBE_DEFER, propagate all error codes
returned by platform_get_irq_optional() other than -ENXIO, so that
failures are properly reported to the caller.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/watchdog/qcom-wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 49bd04841f0c..a8eb1d8f24f0 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -298,8 +298,8 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 		wdt->wdd.info = &qcom_wdt_pt_info;
 		wdt->wdd.pretimeout = 1;
 	} else {
-		if (irq == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (irq != -ENXIO)
+			return irq;
 
 		wdt->wdd.info = &qcom_wdt_info;
 	}
-- 
2.43.0


