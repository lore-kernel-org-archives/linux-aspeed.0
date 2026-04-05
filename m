Return-Path: <linux-aspeed+bounces-3843-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE42FB5175
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Apr 2026 00:02:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqRFk43xcz2yjx;
	Tue, 07 Apr 2026 10:02:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775400522;
	cv=none; b=UhcQeRfY6snOubGL4o+zK4w2tOy0GXUd/MfemK+cXv6BkZs+Av/1/9Fb6MGRMaOBnUqm3QQb7mMDQ5AwEMNlm7QvOAbq6QfTfdZNomftAxhh24vnZiHcy6pnid/6AeKD/OLeumy5r3Xxz1+UR4fwgUwLuAmbVHSgSNMrgSyzySp/k0bhh7yUFeS/bdTXTusSjf9WwjXOtRQei/kwVYf68aUkYBWseYHYE2MG87t2QFqie2DpIDyUytjvbp3SWq/xJ7cpML4XFA/WuA7/IL8TpSnDeorcAJtDnASe+RJbIaUtsHLsn1Fcrc0WuNZMnItkvKtGYTatRL+xhxhePsjHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775400522; c=relaxed/relaxed;
	bh=YWxgN07OZVOqO1Bvp7LxV7r6cRwAlkUDH9yP+maR0zM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ihaODfQytOMamdYrtd+ZdXO5ujMdpsJlqa9NqkDpwfQq2Fe+z3v041AXUsXSO/v8TrqIKvctCd4I19gCci5zdeDltTCywtW9aW0jSUn+zIE40lgRwQxtayKZ4xrRXlEbUTBJm5uHxlqv38k8j/18htncQMDoanD+dRdsvSSM0L5gOY0zhGaOwGO6WkzIm/xxKA0nY6WDQl6iVrFMlOSprndh/GfEAjtsewn6x56ne+cw5w1uoCK4lYWfchxeduiUcIrD+oz8kiE00oDd3QmHV3KG4Lan8oD7haY9+dBQowkLxnFDnlKxX/sZgFLcBAF0G4D5INzboPBUUaFoY8qP3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gapp.nthu.edu.tw; dkim=pass (2048-bit key; unprotected) header.d=gapp-nthu-edu-tw.20251104.gappssmtp.com header.i=@gapp-nthu-edu-tw.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=pfau+jcq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=ku.loong@gapp.nthu.edu.tw; receiver=lists.ozlabs.org) smtp.mailfrom=gapp.nthu.edu.tw
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gapp.nthu.edu.tw
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gapp-nthu-edu-tw.20251104.gappssmtp.com header.i=@gapp-nthu-edu-tw.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=pfau+jcq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gapp.nthu.edu.tw (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=ku.loong@gapp.nthu.edu.tw; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpb1g3XzYz2xSG
	for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Apr 2026 00:48:37 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-35d9923eec5so1883390a91.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Apr 2026 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gapp-nthu-edu-tw.20251104.gappssmtp.com; s=20251104; t=1775400515; x=1776005315; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YWxgN07OZVOqO1Bvp7LxV7r6cRwAlkUDH9yP+maR0zM=;
        b=pfau+jcqT9i94rlnsMgAlci1fDKZUdW3E21uH+0pSJRIxOYVQAvH7woidMDvhu4Y4C
         zeaN9F8sOFGK6vuYY1G/s6ILVpUlQKmPfiYbVzy561glittikWmHAZuFGdc64k2JKYXB
         51hpwsCg5LVfLxCjKb7VVpai0dsnDslZvwmBveqsKaXgyS94WRgvYbhYOwRPoWktGqsk
         icm3IHtIeqhnoaX9h6THKKPoVxuHB/d6uAZqKzMQZeuQHE6y1CNVgC2It5Gn3hSPX+tI
         AIs3+hhuXZ0LowWNYmmVQ+YL+JHSVOxE3YOHValpARn6jYxH2uZxwATPbyDSm/AtqJLp
         JGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775400515; x=1776005315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWxgN07OZVOqO1Bvp7LxV7r6cRwAlkUDH9yP+maR0zM=;
        b=ksYEJA2JHj4MRZi+n4Xkz5g4dwA0H9wgTSBWyxk6NO8V2U2uCN5P1/WmInkbLlp7C9
         XDX9fT/abUsfyaTFLEfGLybLvRAtRo0ds7Pbdrk1SZFG+5Tr3V7lT1y9S0g546PpSkQo
         9wwmEoFa0wqx3vHxF4zUVzwmvIsTDpwcEPewhpMJ0q7Q7bKEj/+vpOJN8UYWbLIA4nmh
         4c+e305zl6Rj+zLoSW77dAooLJzn3BwDLfCVw+w3UeFvNFoSns508/EQgpY+Jt9YEZXs
         NKZ/xgOOjBfJy0wx7TjPOfj/reDrZmdicp6Cyjgb8JuLuvpTM7FLaca2z312QSvewdVL
         +WDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDMiYJMwQPQk2kCt3Id6yCbM78Dk3OrxNnIkrrFPX3FdiQrbRCPn75asbqesM9x5V+01pVKXfFADJ7RbQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxzZaj8mLpPpyxBCG5E3LcO7cooiCWaZGRg3hVRTpYlXU2z1L5L
	5qOqdbLmG5sRSdwDS78V5g2DN2p77T3xGMkYtaAAiwiBAIZLgYwJUU2HypGQSLeQsTU=
X-Gm-Gg: AeBDieugA4MqaXk077PdvTTCTUAj5O4NeHYapzFAaxnARj/xIZToafVnaLaImD+Kuw0
	uUZBz5LOQlMRT4Mjei95ai9nvHH60QmU1ZZdMY8O7JF/ihoD51iy56gS4IMJd6/jnCAh+2js+N8
	IMRhDxJffdI11clye5YNM6Bq5QTnb/8PqF3HW9aPXq5N5AIQDD8MXC3TNrTLvcMTvF5xOWdfLjb
	FMPVAO5kySY3fZ7P2aS0CaAtrj9dB46LzeEhhOefLrrx+FszhA23rrLiz+xLwq1MoQPJttjSJR1
	N8xv+9+WDa+TDtNqF8Jv0qka8HNNmDc1Xjeal/mv1/6cy4CNnipHfZBkQQ/j7KwoUIn50scmb5X
	tc9DYZYgUMiNsE497KhOnwj1G78ZEvt9P5PiL4wYqi3YNVHA91Yi7jEUG8zLGTYr2cG5oFhGuEx
	I0NI3YZui2kjMb0gV9iHZXnWt4pno3FoJtYFwI6HA4Q4vpaoCRSKkIhpXqMmUBUw1KBArgmc9dh
	7RNHzT8IuiUPN0c7f5NKCdAh83FgC0eUWmQdSvDlk3jT/+SKQ==
X-Received: by 2002:a17:90b:3c0c:b0:35d:ac4d:3cb6 with SMTP id 98e67ed59e1d1-35de68417eamr8177597a91.5.1775400515423;
        Sun, 05 Apr 2026 07:48:35 -0700 (PDT)
Received: from tomato-cultivator-HP-ZBook-15-G6.. (2001-b400-e3d8-86cb-6841-8517-e166-bc96.emome-ip6.hinet.net. [2001:b400:e3d8:86cb:6841:8517:e166:bc96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9709b8sm15357742a91.16.2026.04.05.07.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 07:48:35 -0700 (PDT)
From: Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>
To: linusw@kernel.org,
	brgl@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>
Subject: [PATCH] gpio: aspeed: fix unsigned long int declaration
Date: Sun,  5 Apr 2026 22:48:03 +0800
Message-ID: <20260405144803.31358-1-ku.loong@gapp.nthu.edu.tw>
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

Replace "unsigned long int" with "unsigned long"
to follow Linux kernel coding style.
No functional change intended.

Signed-off-by: Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>
---
 drivers/gpio/gpio-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 9115e56a1626..e6af7f3fba5e 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -655,7 +655,7 @@ static void aspeed_init_irq_valid_mask(struct gpio_chip *gc,
 
 	while (!is_bank_props_sentinel(props)) {
 		unsigned int offset;
-		const unsigned long int input = props->input;
+		const unsigned long input = props->input;
 
 		/* Pretty crummy approach, but similar to GPIO core */
 		for_each_clear_bit(offset, &input, 32) {
-- 
2.43.0


