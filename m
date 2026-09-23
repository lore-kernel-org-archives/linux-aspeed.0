Return-Path: <linux-aspeed+bounces-5043-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E49C98302
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Sep 2026 02:49:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqLzC3zXVz2xs1;
	Wed, 23 Sep 2026 12:49:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790131783;
	cv=none; b=fwbtRiSDNhZegts7skqFxtySSlDdyS2I61X6f1J1A05Iro6rBEluGpRePwfHR23YqwrhWn5/7Ou8xiWG8a8cmgh7uFrrDA0q7xVusJOM9ViSDjfggq+iVbOGc/LcZ2PoLk3A9DVZwkKi8bVKhDuJb9OREV2oDFQxgLfufhnaC/xlQp1Q5TfLwic92qKrgm2+pAmlV2Vd5gBfAzSi6zIQlDlJClvgeLXLunwflzw3oNg3BTqe+vgNFNu6OfCDJ/jb3TDBVOmmiciFBfZLxDMfAlJUa+k4rIxFatFZ6+ICJkupxp8XF2A+vZdS7pzhSAUXlybW/Q4yfbCcaHrSzVs+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790131783; c=relaxed/relaxed;
	bh=7ONYe/7w2EXW8py/4ztuf5woebx//EOScMOnkClgYt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jraGYqrI/bX/5hYlk4iQBCOHF6e2fHQk5ApBPPi47CYUqKpW4tSQ3KBGCAGxrl+Dna6xsM0eF55iLL4/RCP0qIwggTJ7irHnh6HytVjoFz+jkeJ5x9u4usrRcAZ8PArFHF/2NphegiJVOPJO0tfn1h77BfTxwStkXF4CzNWL0NacG9AluG6ZVh9E/AQ1Kzc6HPSOI5zCB7UggzmAEocFlbaTEBAd3EwrsP/WEkhmqSukJUnkg8UxBaIvDJc1OUZOgGyY+bdyL1kdaSZPUUNC11W4wXATL4S0DmSyO3fwaOpZ0bQyKXTSZrTKLkygxJs0ab7JXgilol37ddWWuKNDAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2YrT4dlJ; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2YrT4dlJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqLz23nBrz2xlw
	for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Sep 2026 12:49:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=7ONYe/7w2EXW8py/4ztuf5woebx//EOScMOnkClgYt0=; b=2YrT4dlJr+EBT8loz5E2+tD6pp
	RSZljFyYuJpV53y68ASZNZsoTPnatnrA2JlBT7n5/mAdQFUkyE3Yv/SgLVMULKQ7ISEC4y1TUKxKS
	w3e5J2Be6jC2JLWywIVZ/f3Jq6jddeiqp9wf9BEs7WmJ4Z22gwQJT4cLHe0CIPk03ZPDOlB3wgWOE
	3JctFKChtpuujswv3p8T11iLH/zMzVmluSnmbR3o4iv0OInB0Q5P1za4sC7Y/qGo7O3WOARCQlDVJ
	luGDUcxxLq2vwEAwcAkTP1bTiYj3JAv468R6kh87BgxPrm/dd1AHuspnu2EPE+pzXfw+UD4HzVKgX
	jo9jhQOw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9D2z-00000006z8V-1gRL;
	Wed, 23 Sep 2026 02:49:25 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH] docs/ABI: testing: aspeed-uart-routing: use literal block for console commands
Date: Tue, 22 Sep 2026 19:49:18 -0700
Message-ID: <20260923024918.840039-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
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

Use a literal block for console I/O so that the lines aren't merged
together in the produced output.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-aspeed@lists.ozlabs.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org

 Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- linux-next-20260921.orig/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
+++ linux-next-20260921/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
@@ -8,9 +8,10 @@ Description:	Selects the RX source of th
 		selected option marked by brackets "[]". The list of available options
 		depends on the selected file.
 
-		e.g.
-		cat /sys/bus/platform/drivers/aspeed-uart-routing/\*.uart_routing/uart1
-		[io1] io2 io3 io4 uart2 uart3 uart4 io6
+		E.g.::
+
+		  cat /sys/bus/platform/drivers/aspeed-uart-routing/\*.uart_routing/uart1
+		  [io1] io2 io3 io4 uart2 uart3 uart4 io6
 
 		In this case, UART1 gets its input from IO1 (physical serial port 1).
 

