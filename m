Return-Path: <linux-aspeed+bounces-1160-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A55EC36002
	for <linux-aspeed@archiver.kernel.org>; Mon,  7 Apr 2025 00:56:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZW9kh68BYz2y3b;
	Mon,  7 Apr 2025 10:56:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1041"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743852639;
	cv=none; b=CNSQfFYZWtWBYtUQwomgLUDsULK6JyrwkOaqqFeDBJPu7HqLkTHHw7rgl0pkvjAPUrkYG0C8eh4qHg97PKUh/J8d3FDu2wUuLaw24sSXq5TC+Z8EtSOn1YCEpZ+dhFYJ0ROmB+aPrLK64FSoM7enyqK7z/c/T43AfU9ql2NveNFN26y46KxJMSk+t5/JpiqhBhVbqFW5MP+ntNoyulcDOMqUlh+qC1UgRqN/MuViJEIGYhgW5vSCthLW8LI1DhJrKmO2DM0QEVjuNX9PlliosAn+CjDTE33TtXEH+ZkKbUfPhAFdPjD13Q0cl3iFtpaBKdEo3XoUMkuAtTvXVQWQVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743852639; c=relaxed/relaxed;
	bh=SoQfJRPHunsbNr6uBql3ChRC57ynqxjZE49jEW526Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IYVkRbzecnkGZTpdo0swGnJRUdlUFAtKN5k/kcUpVa4g6YakRG+B7rji6emi5DloZEQC8P7SD14UZS1wejLmu5VjGS07/IAD/xD+yA8UH4W5gjMd54i97cV+xYT7sRrwZlMTQmZ+iE59pjatdfPLczso3LI63pS4ZijpRUm4doHDFN2wgQlxllVCnRf36zaIMaUJowMR8w9+LqbwnL0gGzRk+2Kh2xkYWeX37UkCjEUn351uMYbsqjSUM8IZUsgNDIiLtJNF39frwCF3+HilPLJClSZSaSGyWIpDuq3+1PvuuiNo9mJMnVvSLovDdwY/cWbha/4hJfC7pyVzvEY4gQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ni+KC0GR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1041; helo=mail-pj1-x1041.google.com; envelope-from=bsdhenrymartin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ni+KC0GR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1041; helo=mail-pj1-x1041.google.com; envelope-from=bsdhenrymartin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZVCvd4m91z2y92
	for <linux-aspeed@lists.ozlabs.org>; Sat,  5 Apr 2025 22:30:36 +1100 (AEDT)
Received: by mail-pj1-x1041.google.com with SMTP id 98e67ed59e1d1-30572effb26so2571696a91.0
        for <linux-aspeed@lists.ozlabs.org>; Sat, 05 Apr 2025 04:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743852633; x=1744457433; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SoQfJRPHunsbNr6uBql3ChRC57ynqxjZE49jEW526Ik=;
        b=Ni+KC0GRYU1pdV7BRzUTUzJ59VOZ0edSfu8QWE+FKwbMNwyRmt3I137QY5Rp8MVA98
         dsw6egEDLiTJd8rJLuvGviRw9ALY+tX0wNN+fMjizdsabSYOFzufLTmpGQw2myieptEA
         0OWomL4ROqsCfVWzpMhwaJ5K5sNT/zJS65tF+5jYncgUq7vJvxMEjsZrwJnJifob5lEL
         aHn6hegdonLwMHpmNU0VqxrlBtcQLAw/2/6M0nB/3dWbhFEb2TZWj2X2x+OLTFS7ELVl
         6lkXyxYaut6lughyM1KiPQ3qmNeVhT1ujwkYVJozeq7BH54sIJr3kGK+igU1MWzPmL3C
         DK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743852633; x=1744457433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SoQfJRPHunsbNr6uBql3ChRC57ynqxjZE49jEW526Ik=;
        b=UFRCVoBlxPkCh+nQgtN5kOkzAJ02oh2RQxjD2gXmoB0K5of5Ha7+3wqGW3egty1Cxc
         dz+knZGq7PDvOuM87eeTH1P7AvQfWNYckM33dFIIEs4W8mYBgGijkW5jV5C+tDjK0wxw
         j63fQ+NB+7DYI79J3L+mSt/6+2lkwaxNkhecVK2ql04FCg+Qc8+eaIK8e5wFq08ygcrW
         oWnUKjBWoLGTRjkU8aEGfy2+ouLIDWqM9Wk+t5njqU9R6PW6uM3t5uV2uwiPAtPOnlSx
         7tKFDFqGx/tn66N6gUImr/X1T7cIp6TpzuD6aquhOEOj3yvFitP4no7xaVuFnhglirBN
         /yng==
X-Forwarded-Encrypted: i=1; AJvYcCUChpLfdz+b1a4cc8mD53Kr/3IiFysTwcoJos7L/hegUSnBVifcVSHKE/ncFsx3HONxZj3JrZdQs7AhowY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwT45TRVKrs7dXYLYQwXN6qUktxYV1t+T/McA1LB2hnDYYP75h/
	pJOx7Vbl4aH93tlfzszjyEBVGaOuISPM/nQtAP2FXqDlu1793Wat
X-Gm-Gg: ASbGncvrQxdqaKTSsJR85ahcYkVW7StT/rwniHSwTuQnX3bw8rtaAJo0G9XPojo5NlX
	IRyEmqL3YOzGGwLRW2fS4OWhDl0js+7CDuRuDJNHx+aEm63haVA6hDFsGixfHVOOCiDzS0nn92h
	IJamnk0ToT/B9L6JaIGRnnCxwAnBSu1rZ6BIHF6CbyjyTPPeszYRJELVslfxoqkWZWpecSWu56m
	FcCE030+94vHr51S7ceYuKGN5ype4sG9jvOfF1W+6i2H+tnm/IvXqE9PLilA9mp1On552OVCuN3
	vAHHX+5w7Lqt2hKJb6d5IM97OGZ5+9hUQ2gUJ221+VSsas2tmuNSnCRHHTsShLKgRLTH
X-Google-Smtp-Source: AGHT+IG3yh2rev0TOr9Xa1tn7dlPnXmv6Sk9wM2sX7rVbQR8YnS+sCVDoP/A+k0aNPhcL4ZnjR4Y1A==
X-Received: by 2002:a17:90a:e18c:b0:2fe:d766:ad95 with SMTP id 98e67ed59e1d1-306a4860a03mr8905930a91.9.1743852633336;
        Sat, 05 Apr 2025 04:30:33 -0700 (PDT)
Received: from henry.localdomain ([223.72.104.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc323839sm4299234a12.30.2025.04.05.04.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 04:30:32 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: gregkh@linuxfoundation.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb/gadget: Add NULL check in ast_vhub_init_dev()
Date: Sat,  5 Apr 2025 19:30:20 +0800
Message-Id: <20250405113020.80387-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kasprintf() returns NULL when memory allocation fails. Currently,
ast_vhub_init_dev() does not check for this case, which results in a
NULL pointer dereference.

Add NULL check after devm_kasprintf() to prevent this issue.

Cc: stable@vger.kernel.org	# v4.18
Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V1 -> V2: Add Cc: stable label and correct commit message.

 drivers/usb/gadget/udc/aspeed-vhub/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index 573109ca5b79..5b7d41a990d7 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -548,6 +548,8 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 	d->vhub = vhub;
 	d->index = idx;
 	d->name = devm_kasprintf(parent, GFP_KERNEL, "port%d", idx+1);
+	if (!d->name)
+		return -ENOMEM;
 	d->regs = vhub->regs + 0x100 + 0x10 * idx;
 
 	ast_vhub_init_ep0(vhub, &d->ep0, d);
-- 
2.34.1


