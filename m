Return-Path: <linux-aspeed+bounces-4479-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDFFC44501
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Jul 2026 07:32:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0SYQ2pGhz303X;
	Wed, 15 Jul 2026 17:32:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784032385;
	cv=none; b=V2KUZYWi3uJ6OdKGb6KAoyzgWVkRd9JHHdLOmS4IkbcwBm+SUg4tfengybKdPgg7X2fCDfLtabJV0O/epfHLHxTitiAZ5ggijEuaWsmjXuV8p21RRFfrEkDvkZp94JBY0CbKaHuODM5uY/WLxk40Psbu/Q73HN8zYoKnjCxE5YZGxWQtxng6yImNwF0+XhdIL5Y5+2Y7H+ZVBQ8FUOUwgEIw5E1X6oJwwP3xi5qadXXJAvPJroRA6NR7dz9VF7LrseKuktYBSoH3y8gK6Cnsoo1fiw2/sUutsGPL22BkLFKOQ7lbFFXYbpUUL9UMIXOPD76Cy4LeknNxI7XOnd0dhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784032385; c=relaxed/relaxed;
	bh=DNvAJagM0h/ttBqvPmQVo9CO+v+pNiBOB9YPIRh2j6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=As69sTeoGX6hYbbAM46OGuUzJlRz3z50RAnW0Bn6Ol9P3Gsv2UBIRseKuBx54c0UL4v9KCjfZ+jSMRikdxvnmHxuelp8/BcqJdmL+VozuZt8hk5tTzZ2KtWPYpMZ5/jtrySBOzuL8J8YBTjW+gXaG+Iwz9cQ+G91uerGcohpG12lxNqjjeSqNsBC7xt6aCozBQ+ZEkjrM5rGnSe0IQ7YkvC5AyIvVHmbpGhlyu2MelGQWjVhUgHtobnqyMsGFEmdpyF80CIlyY37EiTNbDpnM8HwSp14IJceVfuCDdelDxavBqN/J3ROUHfoCAghuV9G6yn+salFULQSMZFC2AV37Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X2jX3l/s; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X2jX3l/s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzzH40Ydjz2y71
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jul 2026 22:33:03 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso4465888a91.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jul 2026 05:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784032381; x=1784637181; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DNvAJagM0h/ttBqvPmQVo9CO+v+pNiBOB9YPIRh2j6k=;
        b=X2jX3l/sot77TVw6QCy44rdbYCFEKFctulZrYmNSibn314v1XnSl9hGhcplLOJz9Yr
         iGVCgWzj22c7EsbyS7kjUCk7pLRVRkyJfQjniQYV+NRoTti9pdcPJbKjZ4YI4w18Y2is
         YA8Z6xIlUOpr9xF9S+rKrGFv43PIBw0AKBnwCRaV7OolpkDIeUufUEuC1H5GlvmrPpV2
         QNLG9xtpEi5DVlAZLLynJrx6yXrKFu5Jl+Nyr+d0S2FxyUy89h414FIlcnxHSsWknfUj
         89b6K9YGd02V8usbTygqNR1LunqxavmF+i+YuxDJjQdOvjtGv6iSMZG5B4RQLqNc6wee
         T1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784032381; x=1784637181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DNvAJagM0h/ttBqvPmQVo9CO+v+pNiBOB9YPIRh2j6k=;
        b=ABqUkmtTIHkyqOjlc/v7XcG8uTFPs9461YS7FACLYiX+0EW39CkkxUL4sSmEPqTdlV
         xXODsJLIDP93N3Ob1n2OFp0aqQOkzRzf74I6wractt+p6mYcDut4muVFO2ADrqf+R975
         y4jLM7ZKcF6NMaGPLp4I8vxoYEHFfCasby4y2xxcGTCdTxf81h53T703+FkaTEzCPusG
         lXyXlm9m3a6vsvaSSAlOyjECbpZJH6/x/uiZjRYarp1OF3rvfHeHrM+zNuLqTJHFNxXY
         WgkrF8NZ+b9yzMakv9WHMk4HbiwpHVlttdzoy/uUkIC02p8zVrdZu+8DkggORfQUNZRS
         2nTw==
X-Forwarded-Encrypted: i=1; AHgh+RpHTkvHGxf5s6IQfyvvnoWpsur69HEv0/UU2/FAB4VPoL9t0D3Llbs6QpL7Yv8Nusx/zZn+6iTl+rMmk8s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywv6ZBSkvnzxhDzPZXantky3lMBQ7Q7PF/epCy+U6h22J+pJJUe
	dHLhwqIPPYHpasoAOp8C7ouVdtNmwQhwrndH+wggAq7YCgg+knZS50sa
X-Gm-Gg: AfdE7cms2GWvr1j9Bl1Bb+ujUM8Kkd8WzL5MZzH7woqw7vRd22nDGvWOrzwwNfmitwj
	7yLTSXmeN0HkvAw6OQvSf4FxyUxuMsuhjNgIEHWHMs6aq7q6OjJZcp0hvu9o7FS4zTpUcZagDkR
	6rxGE8phsmfh5Syuw7pd9eFkurgLp/P9/c57dvpwvdr4peE9eyLeyF2BHiTPKSdfIPbLFwG+0IG
	lkbbVkjx7O7OPJUzJm86D1bNe3sZyDtEdMmIzD0zdGXU3uIGQOpWHULN6SJm20l874DleFdaU7i
	seXcHbYUs6hSAZyZ1aAizf5ypUfyDJvfMT31wwE3QvbbvJnV9hlFwhZig/nwk7J810cN+EPjDU5
	A2kqvnfIkDvoI3XT1i3sPpcbtrCy2GjKT0Fb/mIPnntOINqPXla9yDBmVqWQa4EPIsEWA66Y=
X-Received: by 2002:a17:90b:53c6:b0:38d:dfd1:7c1 with SMTP id 98e67ed59e1d1-38e17d96421mr2942124a91.2.1784032381474;
        Tue, 14 Jul 2026 05:33:01 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172b6d08sm1443513a91.2.2026.07.14.05.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:33:01 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Eddie James <eajames@linux.ibm.com>,
	Ninad Palsule <ninad@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alistair Popple <alistair@popple.id.au>,
	linux-fsi@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] fsi: aspeed: Fix refcount leak on registration failure
Date: Tue, 14 Jul 2026 20:30:38 +0800
Message-ID: <20260714123038.1523162-1-lgs201920130244@gmail.com>
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

fsi_master_aspeed_probe() allocates aspeed and passes its embedded
master device to fsi_master_register().

After the master index is allocated, fsi_master_register() calls
device_register(), which initializes master.dev and takes its initial
reference. If device registration fails, the reference remains held
when fsi_master_register() returns an error.

The probe error path then calls kfree(aspeed) directly without dropping
the device reference. This leaves the initialized master.dev reference
stranded and bypasses aspeed_master_release().

Disable the clock and call put_device() when registration fails after
the master index has been allocated. Keep the direct kfree() path for
failures that occur before master.dev is initialized.

This issue was found by a static analysis tool I am developing.

Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/fsi/fsi-master-aspeed.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index aa1380cdff33..2a54b6fa3394 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -626,8 +626,12 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 	aspeed_master_init(aspeed);
 
 	rc = fsi_master_register(&aspeed->master);
-	if (rc)
-		goto err_release;
+	if (rc) {
+		if (aspeed->master.idx < 0)
+			goto err_release;
+
+		goto err_put_master;
+	}
 
 	/* At this point, fsi_master_register performs the device_initialize(),
 	 * and holds the sole reference on master.dev. This means the device
@@ -638,6 +642,10 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 	 */
 	get_device(&aspeed->master.dev);
 	return 0;
+err_put_master:
+	clk_disable_unprepare(aspeed->clk);
+	put_device(&aspeed->master.dev);
+	return rc;
 
 err_release:
 	clk_disable_unprepare(aspeed->clk);
-- 
2.43.0


