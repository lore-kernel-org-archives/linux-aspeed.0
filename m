Return-Path: <linux-aspeed+bounces-4663-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92825C5AC67
	for <linux-aspeed@archiver.kernel.org>; Sun,  9 Aug 2026 03:01:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHjM16XXVz2ygm;
	Sun, 09 Aug 2026 13:01:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786090635;
	cv=none; b=Bw0eFUMNL8KrnfDZdVgpOOPNEK8MadHpruXum+Hxi1Pj9Zbr4Mso5E9y6Iju7ZVHGP/P2HcOAEe4xR/H0QYYj03Yd8O8nfMarF2mVCNlVIqIffeU9kRdjZj2WlsMX/B4QsQuAgnmbd9AVkOfXRjUB7+rxQ9LCI0ftDz0uTLXwuLPyrsCmV9dugUhvw3m6tmmP02APl+8TED34NLmdtOUS2lCnyOIm8SJUAqqqlcqIBcxFhDl8fyPp8xvN8oq6832e5OQtd3gRvFqeH7dIQa1PElXp7VuSFVbdVL7IvPFOmbKGrOGFnMWDhRgmrtaQjQdD3cXeIJDgBFqL3ZrvBDkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786090635; c=relaxed/relaxed;
	bh=pRPg2fF5zW2ebng5FORfud2q4xXOQdkBJ5AC1S3iOZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=df0qO+7N1iu8sO5SOA3t8SGLr1Pi+6QfgXGDGxlWO/xEh5q+t9OJlMRhdP0T9QrNEDUsBuOznrpbl8hO/tTzwgFtWyoij1MTtXqWmQwkKf4t/Ubs2/hx9+MpvfQJNdbTukh511ODjWufD+qBdIwSGW2Qra6PKRWjY8JBH354VaGqSFjerBVLR1oPL4kpBOKSc76GqSnpl+C/nKOomV8NiEtj5QYR8RZNBxsAsxui+hAdjizG7vyWp2f2QaOvSFNvhf4NY52ztOdmKh+LdFdgSaWCz8tyoG/T4c81u7uaVdSfEUoDJ8CWquyn5WwBstFy4/jbZJe75j3zq1oFP+Wbxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pstsfvLJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pstsfvLJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGcSq1rHwz3bxM
	for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 18:17:15 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-3900e39d935so2948910a91.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 01:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786090633; x=1786695433; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pRPg2fF5zW2ebng5FORfud2q4xXOQdkBJ5AC1S3iOZQ=;
        b=pstsfvLJW1cnJe+n/ger7o3Rw5deklcPzeNIFtZimd687bjNn287Ug9xREosNDrteE
         gWQsfjhme2zTZt2CSbCBCES5OM9RRQSC+o6imNjZDE0qV/ZyNuC8Kk7TFqUe7ZmijSgN
         48++WoQCaBtZnAG3GQrxvjSAUAwVNc9xJ5wT9a9unuXwVW9t2wl9zLKMDiHfDFWZGQnI
         cdghMMSIAsL2tfP4ac8D8BaZd0YRpvv8JZqGR2Ta27C9RdkAtacB82bU0624d8wbRCvu
         abbY862wYaF7qi3Z5FU8yAyJFnoPUaA0XUXEmkgbzT1k+D//lmMurDToKHMQiqcj3XUc
         7FxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786090633; x=1786695433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pRPg2fF5zW2ebng5FORfud2q4xXOQdkBJ5AC1S3iOZQ=;
        b=Q/ni9BKbU8GMxNgTJcCYmJMfEpmcbhHcuPdsP9jlUONcTa7sn4sE8F5a8QM75qglQy
         se2DMtfwEMA+Mt5A7KMcnJh4ss+Z8Zb8aGUdHPtbLEowmN65ul1EQTKQMHbWjNOQcw0R
         hH7Iqc9u6FG/DFvrj+BruzaC7wDLXXbMwIqStu1UD3v3LtKbHtGGsiuhxpcV7C4VakyN
         kQxxY1q8UDY0u84CFE0Zzp9iq3hkiR9jBLHr2zxX7gPMd9/PXeNMcttSGjGSr+K4PpFM
         1VbAs8hI3kKR70zgaLhKKZQxme/57Le4OV9+ZoDM+wj73IkXqqE+0QL4hzR9j7sXk05J
         uoMg==
X-Forwarded-Encrypted: i=1; AHgh+RrJN1TvuWBmWCDSu9ab2LrNuzTsMjFrmjnagTjLkdCmTp7Lxq5TyMvrc2cfiCWKTCfzFo90DzN8Z1M7TUk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxNtuLKImACEU4StaQI/CmRlgxp168JcmTuO9RLxIsQt6W/YXzG
	Uwt5izsDQ3MUGa82IIOcyofuu5KGuNuRAWzVpikzM4wOvdh8o/LsA7ji
X-Gm-Gg: AR+sD10CHGIva+WYXKIqPrD/vX1MBY+VB4c5pF2QUonL5Dazt7PmBbRkqF7uyjR8sky
	e+t6aaP4fmKnwjSAzXl9TQdzE7II16vLsoAcrQYDh6MUiwqNkHkFJEK/amuvi7dtT5w4zFSUi0/
	5Eec0jdsd4yfmrBSK4XeZpyjdWCEn6Qn/IncqMSKdqYa8IulBNeqSpkzD005W4fQpm2UKxgTGaQ
	01v4n1lUS6lJwLmBnGQPGUJJlhyq6/Fmu1+a62MLrYaLRC205DBaRQoY9TXNBmeqIDqrj4ORQes
	2ln4b4eQbr0yJSuQ73hqGA/nbHD/BKQXoJW9jli9liMrzabaWuo9GMgNoqTPbSFSzAGRc6A4si/
	u/FJFtUT5TWqXudb2bTmh+uGx1n4easM4tdUX8yuDpWE+J+XcGMjzzXZiPhwRRobTHcsrswLcc8
	yHN4lovcn88SA0DdfC5+K72zRKPCaTqv4vEDUzcI7S+qtRSyZ5ys5dr0LqhlmN5giiInaUBJWo6
	368qDupy0Q1+z3fvjZVA6Ms8STLnVuup6qGGzCqVstTgIt4UJ64BzY5yRlyk1Y29KF1b9gxcWW8
	qKKv
X-Received: by 2002:a17:90b:274d:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-3903c534d46mr24091471a91.4.1786090633235;
        Fri, 07 Aug 2026 01:17:13 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de8ddcsm3913377a91.6.2026.08.07.01.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:17:12 -0700 (PDT)
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
Subject: [PATCH 2/4] watchdog: mediatek: Propagate errors from optional IRQ lookup
Date: Fri,  7 Aug 2026 15:16:50 +0700
Message-ID: <20260807081652.38692-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807081652.38692-1-phucduc.bui@gmail.com>
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
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
 drivers/watchdog/mtk_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 91d110646e16..d9c30e4c80e3 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -422,8 +422,8 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 		mtk_wdt->wdt_dev.info = &mtk_wdt_pt_info;
 		mtk_wdt->wdt_dev.pretimeout = WDT_MAX_TIMEOUT / 2;
 	} else {
-		if (irq == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (irq != -ENXIO)
+			return irq;
 
 		mtk_wdt->wdt_dev.info = &mtk_wdt_info;
 	}
-- 
2.43.0


