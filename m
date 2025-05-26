Return-Path: <linux-aspeed+bounces-1239-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F493C54FB3
	for <linux-aspeed@archiver.kernel.org>; Mon, 26 May 2025 23:51:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b5swb4p67z2yLB;
	Tue, 27 May 2025 09:51:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748253591;
	cv=none; b=JTfrzmo7XzNtOPtQF0+GLfAcln60Z+4pb8dbZFsvMLB/smR9Oc7ulrLyb3X+ZUfbyOURjwcvSyPiiKBqPhnn/RmkiUIiASwfMUQUXqi6OsjmWYkk0/yz5K2S5f3Sb/cDepog2lVG1EIPD45OFc98iL1nN4A7QvilC9GDbcTapb1hiB8A7thZ+ABD4hwnrhO3PV4s2PFJSzQanl/TuXc38zPiBGs47uOqtP69eBJMIRS6rC4ecGDlubQxPxxtL3DAfPqfI2jRrLgF/etQl9irTklItXqvWVLact59TvHa247AJGDc+yPNrmbog2OZ4VozYctFtubxDQhrafUh57xZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748253591; c=relaxed/relaxed;
	bh=hw+b30S7iFdzof7KyhoRmjmL7YOJsI0JrMdooAg75CY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=aeQBqCeOwz4v3hn1a68aQA9IHTDCVjmVFHVisyTNsg9TvTYxXidUkQn8NIzvo5zPELQ2/6mbcGg4WG7yWFIFvlwk8ndPJ1VACfd+5AZFHi1HjOXJme/jpUAqoQupZ5N1VuYE6kpSAz0WHhgN/0QuW+enMs/wV7ebQDnek+tfb8VmQhYgrSmhGQ8z6FeomPoTHAonL8XsDjik08KCvl9L3IkTXeiKLJTbAeO5sI6V88ke90zT7EOgqlC98nCvADS2cZMtCAS/Xu3Fy1cc4EotuBduXJDdirM+1lbFNiy2HkEG9o9xgTB5DkrOHDcIxnzhcMY5H7QquXvdft0QpQpbug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mT+fcu6x; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mT+fcu6x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b5WTK6Y36z2xHZ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 26 May 2025 19:59:48 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-742c7a52e97so1637175b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 26 May 2025 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748253586; x=1748858386; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hw+b30S7iFdzof7KyhoRmjmL7YOJsI0JrMdooAg75CY=;
        b=mT+fcu6xJ+Nze/Wwgk69JhVK3lzVxjew3ZhlbOv+L8chuvtJO0mNbARm5jjFdp2ife
         fygLYr9x8TaRo9YupHusuE7lL+2Axhg0c4iyk3T6L9NWvoFE06F70UVqSF8oWixrk5OQ
         7P6KALxGuVBCscvahSh2V4PP8+yEmL6+paNHJOtqNS3Nbzr4ssg76TXolX778Hp2f+ku
         JrFfYtr0KuRjxYJiDiBFUZ9L+3BW93+dItSm4INHTIDVTTvZLdQekC4Ij+E2jygCsTku
         vy+EfZXAgGvorYOw+xTcELan4l8f9ORZInQ0hoIFNq7bmnIdLfEMG8MrYwtgAR8Exfrc
         /7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748253586; x=1748858386;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hw+b30S7iFdzof7KyhoRmjmL7YOJsI0JrMdooAg75CY=;
        b=HFledRR+S3wo2nIt5GYeURQYhYsMhlyvgdcw7XoA6DBl/OvuNYdkDC2ig7UZCFgqR1
         OOo8RyDs7C1BzvcEjAxKkMcjNCpsQhxa7A6t0pFWfuXZjEuOgZJmQWzFCqi37OA2z4Fb
         5jtSZd7eGU8q1a7WhPm8LaWAdF6TKjm6S2BPM2XESjxcffUWAcWTMe6ryqCcRJcaXVcX
         YMkEbkbB8aPKLFw4dnPPdW9TbjiubqrDhDFzPSp9mntpt2lP7d/ou+jtYXESj+qv2VDj
         nSNzoeK+HXW5cIcyWlfL/uZINgPMvj/DU7EmfcbNcpXLfJ6wklcwX2viMeNoEFyCpxBq
         33TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqIqFxEYo/KGMhmloZtTgwUd9SBR5WwgN2Z3WgPYYx4dcXndSIcmukwY+mkR+3O/hFYOzu0sJoCuTMOR4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyR2+KdsQJfypD/MrDR6um5Cd/Jx3RJ+Rj60pRjB0Fc4cenkj3v
	TF6T0CZqyaJeKQmZ9MKcEYDfOqn3IklGPHmb7ha+FZ8PTN8Pxbhql4p2
X-Gm-Gg: ASbGncu1hAl9kNwy/hbBiWPHGpEqlbdYfZqNdoF0QFs5d5iD2rFtrWywXIvFTycYxFK
	M8rvpP1br+hEvxpRNmZn2IxEC+S32xcx7i2iJFRNq6x8ONNR11iJbcjyBBW/zEJZYkZG3ZeKGIB
	rcDPXvLmv9HmyhknaFbooxKptP0HEgXjNgUPEfRmouZIYRlteKagQY4DAfEA4ROgh2RQPTuAWd7
	jhfMCgOEA7jCXFld/iaPbl8HmZzilYDUAy9E3DHkZ5Ftc6v+YAREaYS6aJLEuI0x8KoADkhomvU
	QlhdopifraHm9pYn/BjYiWOsmtFJvoCHtYZbj7Ev+23q1N1xCWQ5ov6C/jF2IQJu1SwpE722uMQ
	ITpAJRKE=
X-Google-Smtp-Source: AGHT+IH9dqXJxz5O35iZ5QNfhu3qUkFE26No9xhBeqSmFEjU/+GGgVc1uQOTE9NbI8GJds6O8V8qsQ==
X-Received: by 2002:a05:6a00:8d6:b0:740:6f86:a0e6 with SMTP id d2e1a72fcca58-745fde9e5dcmr11477511b3a.6.1748253585822;
        Mon, 26 May 2025 02:59:45 -0700 (PDT)
Received: from dea88b1475bb.. (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970d64fsm17225525b3a.64.2025.05.26.02.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:59:45 -0700 (PDT)
Message-ID: <68343b91.a70a0220.2298c6.5b57@mx.google.com>
X-Google-Original-Message-ID: <20250526095924.2814310-1-LeoWang>
From: leo.jt.wang@gmail.com
X-Google-Original-From: LeoWang
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	george.kw.lee@fii-foxconn.com,
	leo.jt.wang@fii-foxconn.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH V3 1/2] dt-bindings: arm: aspeed: add Meta Clemente board
Date: Mon, 26 May 2025 17:59:24 +0800
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6822b830.050a0220.27a24d.d064@mx.google.com>
References: <6822b830.050a0220.27a24d.d064@mx.google.com>
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

From: Leo Wang <leo.jt.wang@fii-foxconn.com>

Document the new compatibles used on Meta Clemente.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index a3736f134130..4416a40dcd86 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -81,6 +81,7 @@ properties:
               - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
+              - facebook,clemente-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc
-- 
2.43.0


