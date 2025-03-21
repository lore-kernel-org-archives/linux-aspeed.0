Return-Path: <linux-aspeed+bounces-1117-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D95C28B30
	for <linux-aspeed@archiver.kernel.org>; Sun, 23 Mar 2025 22:46:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZLWW93L8hz2ySm;
	Mon, 24 Mar 2025 09:46:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742560884;
	cv=none; b=cr+QcNCNuC4WYhAbIG2bNtLNci+uWuDJLA409jABAfdN3YCc0xZIJZC2gzgihXaAqlBgKUH+TI1ZRzdzuzenmcMgmjwKp71p+LlkPMFiGPxMgGr4DuUK0ZH8Ttm8B8oLF8vMRPlOKez5RYg4t0N6eVPBlMLmB+V3B3XDeDV7XNzh0xcyV1Z0LEY1wc1Co5FoLbXG2hurgA47/sPTRxA5/MDBoQVYasAjyQWyfZnENPzLwRX1PxSwWYlqiLfRnJYsl+OVXF+MpHFlkh8UVYFnhJu6ogIo+s21r6oPcNLuRGRDD7guZa7YEZivaOx2JP2TqJKm/PoHw+L3QBeq2bEjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742560884; c=relaxed/relaxed;
	bh=Q+NiAZ9mdyZTQmFAQQ+DvuQUzdXkQ4ZbSFQA5qFBOIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mDob8qOjr/JhGzJYzn/f3q3tiVPT6SmYtb3E1CzQWXLq0VWCD0HlQlm6uJkHw3ocajwjFBvALiMeGmR2mVZXXNHNlChE/8QaNRYNNfrTj5T6kfFcggodp4rIvE/ekJ11IjWuAE4eCD9c68BE74iCCel8CGcyNNfmM4+Bo4kuilrKtcbe2oOVyujQ7z91CAe66Ab3m/WGU8e2t8wR4lAhromXR9/E0iCmk8LUbWJfBPBBxFHdybwfiPPOvp2MXtDJL7jnfEx3hslN6K7X6UOSzTeEp7ISPXIj7MYDwvuS3d3+868gMCEGtpXtyUajDL+dmqSnSD2VrWv9xofeBvC4IA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ywpk6WU9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=jasonhell19@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ywpk6WU9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=jasonhell19@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZK2BC4yKkz304l
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 23:41:23 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-22435603572so34982855ad.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 05:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742560881; x=1743165681; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+NiAZ9mdyZTQmFAQQ+DvuQUzdXkQ4ZbSFQA5qFBOIg=;
        b=Ywpk6WU9I6bzXmZVZfMab3AeR32aSltUByyg6pRfKrupAluSGHDCvHcsIWV3uh0G3u
         KcffWwHBg7fxKSAkzLC5ehat1C0mmDg2EBVjgg/cKn/JyOZJeuRa5GB/PBHUY0DNk21K
         fHEqeEYWeuQ+zy7BJdv0JBhfMjCDhmLbKBRLS11D4qWdmRXveiEKBsiA0OSk+4jFkoS7
         j8vXHxq4osVIp7cw8WjCJoj7QZ7u4qsZTJMk5avSNXO8ZZbKUA0pZ3+zC9UrfXePkJ2O
         U1kuas9v2najV/piO6jbVuUq/N23lMc/IQmlKpEbx8nVsVBUY6QviHQ2SObFOtCO1KaJ
         qmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560881; x=1743165681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+NiAZ9mdyZTQmFAQQ+DvuQUzdXkQ4ZbSFQA5qFBOIg=;
        b=lB7iNOChvKcOtVzbIuDsTBbkbfqQG/P59tsiFRjeQRIuX4xOsfwKLNGG1OPODMEnjO
         fpry4p0zlHCyoCnLKUrT2l7HnfeJduTRgBfPE0C2CqlJKR+n2vv5ZdkcACksPYyCZnyD
         INKS6Zbr/fDvcUXdkewk/cd4rHM45eR9OjXz/T5SKroqRERYZztG4jYpXYM3odFHae/p
         bDOENvowvEzl8Du4R8/cNpx/w5ryp4VqLFP0IMWunBobtFrylz+2KX8T+eGI1yi5LAWS
         uTjh3EvV4jFYHtiEzW6eBsDbJGBkeFRNMQtU4ksZ/YWDKlUuFrd/hLsQOSHbdEAAsRIi
         /rYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO5aZMeBMNAYbwdWPqvFPJIhzXAo1TlyqLmeSWTe9hrSmvGq7NNYr4wolL1rHEStfUMncYIbfZWZh9jG4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzlzRTYOJhky8LtkpL/SjFE+lGsi2Oo/L42YrdC7ZBv1CKPRhaF
	/7twaGsBP709P0qxQdsV/iybMCnmvWCo7ltK/8/2fEx0FHwGrCRm
X-Gm-Gg: ASbGncu4i9zkbeM1/gZAKTdcavcrEI5ZfkCOFJgm1TYLCTgCxXdcEcu4W8nbDhkNAMj
	nhV9EZjLlCnGUIWjcXwQeCHvrBMXyuY/Qoz0WZIZZLhInqAWxgyTNZLVYWUsCuHqc4XoUoYjFWq
	clQY//IkLiQ4rEKEaoF03IRoJfRSmtKkWJp7ZWzA/1/GoMxmIxgRU3TITiR5WmXxLWblWCSsUMW
	m5Oth2je8xXVjX30gs7H0t2ev4RPY3uyy3fk9ha3Pc16YHcYwidbQdR1z7iZcEa3Jp2DXO8lbJc
	M7UQ6V9tQJBUHL5eR0YEPJxNx0ryytoIXtgtUDT+kPPxViiarjxuuWptdcYbz79UKDXXX1OppvS
	l0+ceGtztP+FJXXQyaX80YgYLNwt3mrCfbVtm10Dek+rR3qnIQJ1FzFyhfwE=
X-Google-Smtp-Source: AGHT+IExgVZ4q/4fohD2pxnSiano84+Gjnet64GgoejlycI2L+z5k6c8k/m9ePdFfCzgOHfdnbckMg==
X-Received: by 2002:a05:6a20:7285:b0:1f5:6f61:a0c2 with SMTP id adf61e73a8af0-1fe4300fe40mr7650260637.34.1742560880874;
        Fri, 21 Mar 2025 05:41:20 -0700 (PDT)
Received: from jason-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd5c90sm1815432b3a.51.2025.03.21.05.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:41:20 -0700 (PDT)
From: Jason Hsu <jasonhell19@gmail.com>
X-Google-Original-From: Jason Hsu <jason-hsu@quantatw.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: yang.chen@quantatw.com,
	jerry.lin@quantatw.com,
	Jason Hsu <jason-hsu@quantatw.com>
Subject: [PATCH v6 1/2] dt-bindings: arm: aspeed: add Meta Ventura board
Date: Fri, 21 Mar 2025 20:37:30 +0800
Message-Id: <20250321123731.1373596-2-jason-hsu@quantatw.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321123731.1373596-1-jason-hsu@quantatw.com>
References: <20250321123731.1373596-1-jason-hsu@quantatw.com>
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

Document the new compatibles used on Meta Ventura.
Add subject prefix for the patch.

Signed-off-by: Jason Hsu <jason-hsu@quantatw.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fb..a86b411df9a5 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -87,6 +87,7 @@ properties:
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
+              - facebook,ventura-rmc
               - facebook,yosemite4-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
--
2.34.1


