Return-Path: <linux-aspeed+bounces-2231-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3A1CAC597
	for <linux-aspeed@archiver.kernel.org>; Tue, 16 Sep 2025 00:19:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cQjFR1WWSz2yrF;
	Tue, 16 Sep 2025 10:19:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757929663;
	cv=none; b=hzjqN6pzglb6OmuTK0gT8BX0Y0360CHNIsBlfXDaFhW70jdWgZnQV5YtUQuTrHcweIfwpnQn9F79OlG5X4a7S6hiTJa+xy0Nxbeoc40n4IFxv4I+RWENQsSd9m4YsldvXBsxgPOShL5BLnh/VO2nBu9SYD7RVn/4bQtHUzNigBHgUl0JjdRbc2/9kdcWbF/o4G30czFu8O27xL/O0MUzjJvBIBdCxR4MdYP0pPVHwFUYRVf0Gr4DaFXElprU6MRSur5hDQHWN6woQRyg+7Zne5or3uL5dcJCTQA3grCwLp4qgaX+8m6mfao9tq+ERotMto8JAJibrliijmL1FiLpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757929663; c=relaxed/relaxed;
	bh=puq/QVPjJHJaaP1wqvS4Jd4MbGPB7yk1PKVylU/wUU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IInxMBcQyOiPiN+w4qNi1DONziThi0E4S0ej3lfX9A3ULykvzVjOU3GgtjhqXQUbV9enx3taya+QazGzszwEmYHuRnf3TeYRvnlgvZJsM/qAkfafsejzMBmRRnZNDPnqsHAi8E9gN6u4ABqf0Pr3B1HuVWsrf+09B904/WXnjKCEIBbDwMwM10A9LZsXPK73ksXzX82LCgPg4rzLveHA+wB8xTXfIhSRhCQiWqOKoD3lX4lrJ3EMYHWti2R0kP8Y4zodARyGab51da0MEqH4pOt7PCn+KxOWP9W4ZUHyTabxDesFdlWiZgUfzV8uSsNblQDWt6NRQAm8ErSF+iVTZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DmfRUOLF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DmfRUOLF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cQKvf6d29z3dGr
	for <linux-aspeed@lists.ozlabs.org>; Mon, 15 Sep 2025 19:47:41 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-77786498b5fso767412b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 15 Sep 2025 02:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757929659; x=1758534459; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=puq/QVPjJHJaaP1wqvS4Jd4MbGPB7yk1PKVylU/wUU8=;
        b=DmfRUOLF2l8r+zJJSdcs+1fDkD1+A6DacTpQrXWKNKus21vyehNoFE33cg4ETioHE3
         /iEcIv2qSjHoB+Gpk45GBlJARfE5GIFGbAxbg+ywt5IXnia4zOKISiMNu776BPGXYqM5
         nD+NRn6+Ny2IT9DxWUfyR+KF514mTOGfujg9yWrlsyH0Ajfy2OVL27JqLRzrZ2n24Syb
         ulC0z710JEmTxMC2b7NkmUVXqh5lO7mXf0dtgrcJBn0hUzi5Tt4lfAH054VAeOH6FU5B
         7wVrewHEBwqzcTQcPG7d3ZW7DtBV2wak2xS045DkboWdf0MgTQwVLGkr+yLpf4RDr9Tz
         C5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757929659; x=1758534459;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=puq/QVPjJHJaaP1wqvS4Jd4MbGPB7yk1PKVylU/wUU8=;
        b=NHWgrB85Cnn9/OcT1IwJmpqlPNQckRZAGy5m70dKG36TVPhFCwotd/fbj9RjKRYTFd
         ndz9dDOua7dErR6e+e3bFZLwmt/yqYnK37wcolZ3cZlzHOa9a7+Vvxrjtwlc1+puQMdx
         NvLHulkUd0ilLcmcR6Z2niAlE9AhsQCStn4UsEnzH7pwX6u6kUo000VgCtSWw943NQID
         iLm/ZajENFFiitVLZkPUGbPth4ahVG2YcoS8+a7mWoxUGOj++QXVCCTYXlD8dJpX++eA
         tsyvCBPU60xzkgoX8qS8bhe7+Hd0ittBER4PGWx3EHBHq4TT23kTreGoySDhAk6nfL53
         QPww==
X-Forwarded-Encrypted: i=1; AJvYcCW+p1fcgPJTnGx3GE497OqYF0pnurNgJzLAv//NItut1EL2tENOEg/4MebFnYi/WWgcNBHtmbWyHSU+RZs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyag40+U/MVwbI3jxMQiOTIqfek9Az33jUu+bkOKjxCRdaRju4v
	dFONQevItYxVYg1EOd0Dua3ClyU4G7Gez0K4kJNAfVTJYbD0BgCw5ImE
X-Gm-Gg: ASbGncu9Ej+eNnxIBoE+YRijuhw+c3jvZXVqzhGsmYzJh8n88LRHHHh2aQZnX0VxcIL
	ZGM49zuWwTxuikf/gj99qG+UHk4bvB6WZAB+vrz2w/daRrrlH3znEbPtTFVqRhWY6360OnGYVew
	pkj5eQuGD4+Ri8AnGl07VnlW5Te90JAgOz8F0mdNlx/yagZuCD07cdPt+Nly+AJsu1TPzg3nsQu
	dc/TAk/hKHceMu+JlalY7wojd/jJMJi7ZE4Y16ZxwMILu1ArMAlRiXtSXrtjLn3tLNfWdLhoxDz
	ZvScP9OV9wWXpyT2ryk/vjIgaEweJfhcgLzP2Jxbq98LfwkAxXRbMolw2XGuDgqh9bPxlL86E/P
	AyJMdqT2PLDrspiy03nsTaTDAcK2OvaST8/pl0yRkfR0R3QRQ6iETJFRDbEI=
X-Google-Smtp-Source: AGHT+IGkXts2jRdzrIsnTzuf0gryCyKv7pwYxHT8stwUeB3vyz3wWYX7tzBsHMaYizcHXmUk5+6mwA==
X-Received: by 2002:a05:6a20:432b:b0:245:fb85:ef58 with SMTP id adf61e73a8af0-2602c90cbe2mr16311805637.40.1757929659394;
        Mon, 15 Sep 2025 02:47:39 -0700 (PDT)
Received: from [172.17.0.3] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b184f4sm12997210b3a.62.2025.09.15.02.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 02:47:38 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
Date: Mon, 15 Sep 2025 17:47:23 +0800
Subject: [PATCH] ARM: dts: aspeed: clemente: add shunt-resistor-micro-ohms
 for LM5066i
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-leo-dts-add-shunt-resistor-v1-1-d65389148a3d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKrgx2gC/x3MwQrDIAwA0F8pOTfQylpmf2X0IBprYGhJXBlI/
 32y47u8BkrCpLANDYQuVi65Yx4H8Mnlg5BDN5jJLJOdF3xTwVAVXQio6ZMrCilrLYLPaFdvHz4
 aZ6EHp1Dk7z9/7ff9A4VGMn5sAAAA
X-Change-ID: 20250915-leo-dts-add-shunt-resistor-8f96c94cf2a9
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
 leo.jt.wang@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757929656; l=1194;
 i=leo.jt.wang@gmail.com; s=20250618; h=from:subject:message-id;
 bh=cxAqupFOX5uFq92Avu8qu3m3xhpolK/5U494g4n1Fko=;
 b=GRx+rMoPC+Ks8u7cyFLnZgiZtR2njjInKSWufNm641lfB01ZSutgDpAepPQNVYxa1v3HucGVm
 CXu/0vJgogXDF0XZGPSB2GXDvlJT6dGy7IwENtdjSa5g1twGsK3oMQP
X-Developer-Key: i=leo.jt.wang@gmail.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

Add the 'shunt-resistor-micro-ohms' property to the LM5066i power
monitors on I2C1 for the Meta Clemente BMC board. This accurately
describes the hardware and is required for proper power monitoring.

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index ecef44d8997775b26cac10353b42b03dc644f033..a614f947dafc9a6628c3f3d45b62ff3ca9d2b618 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -642,12 +642,14 @@ &i2c1 {
 	power-monitor@12 {
 		compatible = "ti,lm5066i";
 		reg = <0x12>;
+		shunt-resistor-micro-ohms = <183>;
 	};
 
 	// PDB
 	power-monitor@14 {
 		compatible = "ti,lm5066i";
 		reg = <0x14>;
+		shunt-resistor-micro-ohms = <183>;
 	};
 
 	// Module 0

---
base-commit: 3708a165a98c23cc83216deda88bc7d64ba85527
change-id: 20250915-leo-dts-add-shunt-resistor-8f96c94cf2a9

Best regards,
-- 
Leo Wang <leo.jt.wang@gmail.com>


