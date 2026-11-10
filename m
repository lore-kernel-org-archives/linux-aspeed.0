Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A6F606A336
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Nov 2026 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfpqBY2e
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPMb02b0Jz30V0;
	Wed, 11 Nov 2026 10:01:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794310540;
	cv=none; b=GJ5S3JsTrisUu0FsoCE2sX1x8LfBhDvJTtqsNHDFOHhTD1U1N9mbudBVXruljdHMtYs/y9gltTdh3Jz8tJEpdZ3QIK7kPLDr7+f2ypTRZLeJnz74LwOa+VaiwzPciL0FFJQqngfb1zJBR1qYydTbpySlCf0XNX87Z7TojC4kgcAWTbwxA7e5f+qol7p0o8Mj87abdEQc18q5Wo+BVQM3RPkvyV9ekgcs2jOVl4vkx3flcy7TbFc0GE+qyVoH36pfd+cmF4boobgIuS2PoEvAza3uplTG+w2Kb+pMOCeXOLata3CKWqbQ+4iTI4fp/2RtZqX6llK75xU3qn3bXqUsuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794310540; c=relaxed/relaxed;
	bh=hz2duDh2X9IqKj9QHw0i2rUbwpVwIMp0NVPlYZKXIes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cuqb4r74OYAuAx6tZ6aJu1bOC+dQRT4yePlKVzHp4SeCwB44veDH3YdKw51Uf/+pa/tR/Ju3l1R4k63HbrY/onM6aim0n5+zJkEHGzOWudLW8C0UqYmhZ0jCgXziXEOIbQ75RbdcRp9xqxa1bV7GkCdT2kSopP30Oja96DVTpD7HYxbNRiWH/bfSOHTs0RvFSjfLt9TBNj0T937atSCySFP9KtiSTcZ/AIpPyjUPU/LcSl1VVKf4eNPfaxEAst7BzMwLmTgPcsPRcTOc3LIIsACfpgSJ4D56lOyGgDzyNnvw3FOmfGG2v047y/waYUFxrxCtI6/49LhOIn00jgZnUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfpqBY2e; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=hj351016@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfpqBY2e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=hj351016@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP4Mv0dVfz2yR1
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 22:35:38 +1100 (AEDT)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3856180eec.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 03:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794310536; x=1794915336; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hz2duDh2X9IqKj9QHw0i2rUbwpVwIMp0NVPlYZKXIes=;
        b=xfpqBY2ea9ts4XYuEe1WvTbynD3av2E6l+ML+Of+Kxn3SVg9Oq04wF0zm9AwNk/bGx
         IM0ML1LKrpsrJrVHCuTe015nyHhpqcENUTjUvVWlE34Jq7SvfxFXn3lMo32IJ23EVs2p
         u491LDXsrJ+n61mWtHLBoPO72Fa5InSoaLWGmTiThc/7jtOhY7l2nmDLPFNhURBqR7Ug
         LsgqMP4+CufjAmi2otXbCtb9tINjf3MAB+T34YdDXCv+NjfkXFu6zjivIJnMZtawStIV
         AjCBNsVVYecSjxlXEs+P/nFSlT9o+Lo2iatYAHCrVkuIMJAicTi5cf6xz/3ZBi//Nm6m
         aspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794310536; x=1794915336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hz2duDh2X9IqKj9QHw0i2rUbwpVwIMp0NVPlYZKXIes=;
        b=QAGnNRpIHqmZPga6YWgYHg7kWptK4GZSpimbf8YewQ6h51TpW3sNmlgMNhEmHvHcAb
         GSWUbZ7+Z2ALMUFF1089an6Li1CiIBCV7tmKj+K6ZlyVvIAONHhy5fUGHRghiiaY6r0I
         QFmoQ4zsCBx7vv5v2hqfp/cAZ0W2avJMBjhjD0f4CpMtUNzHsREraREsqIA2zMmaV+fd
         W3fLD2JgKgV3OMrzHYV8lFKV3UUspattstNT1upwDScd1uOk8kOSELOZ8AW/eibSJTN7
         PLslT+hODUwzj8/9ZIce2o4Kdfhq4EcTvv5kxLZOhRYf1rXD2013oiuGM1d41i6K0p3g
         pHOA==
X-Forwarded-Encrypted: i=1; AL+hErG70AxUVDiCOWTQ5A5A2YLRGBQxS6e+C3DdFarnY1Z60wfSz3yHVXSOl3SUNKh0XBnP/L9e46hVdDUVOmI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9U5QDBEYZk9D9CXP/ZfYTpULsWjgoJwVJKbU58M0IvO+9d+C/5
	tEDXd7RGOIASd4epmY5WNI9Ulo0yr1e75/FVcHnOXvjwXbfJ+QH6wsbF
X-Gm-Gg: AYBFou3RZcqSAFwmfP7jWAeKNVNGYCjU5UmXSgEC/5+MckrFDPK9IA4r2BFA3PlpS/v
	9RRF++mvNSt6yVXaUfi/Os+u93KfWImZpol94ishH0R18XoP7r1biNV3SRvUHFBJ1mLMjex6zZA
	pucEViGuEplYZrhyjVv2Z1rTaKV/lrDm+ULbpN0sU7/6Z7qBeTJ30uV3/tXtRAuTrTZwhi+BxUB
	+NV+9L/pxtwPK2jZjjTUT54KHLg2FyevNl2OlmUold12eeUKSZYOeRGNAVg3kPApeC0etSI+pBn
	gnXsYO4dZ10A3g0aK1Eyn19IvT2aPtsuv6QDLgJws6qVIpGkX9+ybxQqQJlWXHEOB+SpeEsHeqq
	JRb8XpdO9NLythxenu91pj4O8Apga/XKhBTzK/d6xZqpXK8TWdtRPg/QpXQtF/WV7zjv/XWjsbL
	lJLEPEmo5NUQ+nMkHvfDF57ly97nvRhgVGDJ4VnP4e8rqpqXGJ9Tq3K68OmvHltZ2QgiealnoaZ
	YhrVGos4GK0J6HgVJJkUTfmdOqwDMesLIjBBYwwUjsdg4s9p6TFDynFD2CidfrK6dLfV0tttoQt
	ap/OGCD8V2ZVfT9neNio1V1kNU1sMsPyc+OnxLbX4w3oX9P8
X-Received: by 2002:a05:7300:54b:b0:36f:350b:3838 with SMTP id 5a478bee46e88-3751fa3d477mr4851767eec.31.1794310535882;
        Tue, 10 Nov 2026 03:35:35 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520512ec1sm6098205eec.12.2026.11.10.03.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:35:35 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Neal Liu <neal_liu@aspeedtech.com>,
	Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-usb@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] usb: gadget: aspeed_udc: cancel wake work on device removal
Date: Tue, 10 Nov 2026 20:35:23 +0900
Message-ID: <20261110113523.2517891-1-hj351016@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ast_udc_wakeup() schedules udc->wake_work to drive remote wakeup from
process context. The work handler ast_udc_wake_work() dereferences udc and
takes udc->lock.

udc is allocated with devm_kzalloc(), so devres frees it after
ast_udc_remove() returns. Removal never cancels wake_work, so a work queued
by a remote-wakeup request just before unbind can run after udc has been
freed and dereference freed memory -- a use-after-free.

Cancel wake_work in ast_udc_remove(), after the gadget is unregistered so
no new work can be queued, before the devm-allocated udc is freed.

Found by static analysis; not runtime-reproduced (needs Aspeed ast_udc
gadget hardware issuing a remote wakeup that races unbind).

Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 81fa495..20dcbd9 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -1460,6 +1460,14 @@ static void ast_udc_remove(struct platform_device *pdev)
 	struct ast_udc_dev *udc = platform_get_drvdata(pdev);

 	usb_del_gadget_udc(&udc->gadget);
+
+	/*
+	 * ast_udc_wakeup() schedules wake_work, whose handler dereferences udc.
+	 * The gadget is unregistered above, so no new work is queued; drain a
+	 * pending one before the devm-allocated udc is freed.
+	 */
+	cancel_work_sync(&udc->wake_work);
+
 	if (udc->driver) {
 		/*
 		 * This is broken as only some cleanup is skipped, *udev is
--
2.43.0

