Return-Path: <linux-aspeed+bounces-3346-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE17BD44C59
	for <linux-aspeed@archiver.kernel.org>; Thu, 15 Jan 2026 15:05:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsR9j2Jd0z30M0;
	Fri, 16 Jan 2026 02:05:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768489513;
	cv=none; b=k49Lm5WZ4slBRQlbW7f+UkbJNymx9hkhDjZHklx1uwjoj0arqJrnqykxA/8DaAIT9P/ty4H9U7kCcy9JfrxsSMRY97lrIQbqkYKonjnVFXAfi8kJx9CfqVvHEiH7+oGZ1jTN3p6+LRQXDEVI8pAFTcshmwfsSb43ObCkdEAwAO1nE6JWbRGZGzSEKpxamtj7m0GeWDrN+lU45Cx4YWsVYyb9uKOc3a2vzgcDRjQC1lmwyWAozofdBI0Lt8qBSYwMaNQxsub6Ik+d7TSGEAYK824lX5bB9/oW9ESukn8xYjYXfwgoKQI4IH6iuJWDx0qN1F2lLvvpK1AhXUnuGD5n3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768489513; c=relaxed/relaxed;
	bh=niR+VuOPISft49uKWVuN3uJ8mcdCDT7kQgn6mpEoa04=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSmIJg2L9nMHPxREncQi1yclSQioN0wyTmBEumXfOoSVwHZ3hFdmLYwILIwDwM0bC59cztfRALiVDUM0X1qlEC3AEZqTfppvwyUiaKWB2D1uOSVbLw1JH4DLisjQiVh7P5rBdC60V+r+AHkkJGdZb+ndKdlu4+3+DbERn/7HIbUxtVffhhkqprzUL95Nkg1/s0mKdaAJQGECYFC278bAgygVPHrtCRtYGTtBX3hVtSJ0ldkzlwLzfgf6kSZ880Pp1zhX1Bs0Nw1f/4+y7Vnj7PQ8Qa4v/7fzSzwDBHOdKQsTscWIYHzOZeIKw+WP+THobT/aSMD1W86xUTSz5jdmuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsR9h5LsLz309N;
	Fri, 16 Jan 2026 02:05:12 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 15 Jan
 2026 23:04:55 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 15 Jan 2026 23:04:55 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <clg@kaod.org>, <broonie@kernel.org>, <boris.brezillon@bootlin.com>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <BMC-SW@aspeedtech.com>
Subject: [PATCH 1/2] spi: spi-mem: Protect dirmap_create() with spi_mem_access_start/end
Date: Thu, 15 Jan 2026 23:04:53 +0800
Message-ID: <20260115150454.1575970-2-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115150454.1575970-1-chin-ting_kuo@aspeedtech.com>
References: <20260115150454.1575970-1-chin-ting_kuo@aspeedtech.com>
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
Content-Type: text/plain

spi_mem_dirmap_create() may reconfigure controller-wide settings,
which can interfere with concurrent transfers to other devices
sharing the same SPI controller but using different chip selects.

Wrap the ->dirmap_create() callback with spi_mem_access_start() and
spi_mem_access_end() to serialize access and prevent cross-CS
interference during dirmap creation.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/spi/spi-mem.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index c8b2add2640e..85702a77b3c8 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -708,9 +708,18 @@ spi_mem_dirmap_create(struct spi_mem *mem,
 
 	desc->mem = mem;
 	desc->info = *info;
-	if (ctlr->mem_ops && ctlr->mem_ops->dirmap_create)
+	if (ctlr->mem_ops && ctlr->mem_ops->dirmap_create) {
+		ret = spi_mem_access_start(mem);
+		if (ret) {
+			kfree(desc);
+			return ERR_PTR(ret);
+		}
+
 		ret = ctlr->mem_ops->dirmap_create(desc);
 
+		spi_mem_access_end(mem);
+	}
+
 	if (ret) {
 		desc->nodirmap = true;
 		if (!spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
-- 
2.34.1


