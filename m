Return-Path: <linux-aspeed+bounces-1248-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD24C5AD49
	for <linux-aspeed@archiver.kernel.org>; Tue, 27 May 2025 23:52:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b6Ttr57cJz2xKd;
	Wed, 28 May 2025 09:51:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748358625;
	cv=none; b=mpdK7glQy7T6XB5BBwc7VmpU6kltMu6XpNq2KEEEjoxA1ie9zP4vVyFFRjIjtNRbYMe7X0KACKbZPL72OQwQSqlltlZV1aZc4MyEF5ldQCCXx+ZCbIhpEpKFqJnv/8VEYBDg0wmkq/D5HM8WT+CcX6OitV6ekCXRbvGfWXwRpENZTcIjI1eftGWK3gMCdcL9+kzuDnifulCvKj+6mMRbeqV3G/hes+qVnUN9qXKOvLkah2an9yCOsNMzRUjd+PxYLCK0dF/FFqJBdmSQMWe3xZMDfGemoEznFMhUgZ86RlYzfAru7NE1kGfc9+FFgW2o4hX9/s7oQXnYzCigA27ivw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748358625; c=relaxed/relaxed;
	bh=TcDZQwTmMdtyKKt05qTa4r45+8RvNA2opPyhd5OidXw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bvhc4ItNfwGQ/3+E3jWMMb6vur2Umw16HeEcPgVLm7a37G1IXgUPOf34MZ4J3HDTPfjoygzozALBJCo0S+pspAfE7KpeYMgQuxM0Mi9DXdoMuXUxrGsAMSlQx+XEiROHRBFiJAM3d3kqBNUUMso0thbIuTJ7jPPTU/moucxKcjjK7z9SJpqVbvfB8ME/EoX1Si6gtotEyHpa4a6IZOG3szDejlV0EiN3YL4Pg8PtCKXBJy0hXy1f8LFTHKB/gb/txnDjco+iS9OrEWNmbCZZP7tdXzJWkq6vwK6R9+nnXY9FOgBPHHQqB3Q8HGInlGrfx7CqzXg6zspXy1RseNBaxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=F7RnRKiN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=F7RnRKiN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b6GKD47WWz2xPL
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 May 2025 01:10:24 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-742c73f82dfso2544090b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 27 May 2025 08:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748358623; x=1748963423; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcDZQwTmMdtyKKt05qTa4r45+8RvNA2opPyhd5OidXw=;
        b=F7RnRKiNb58jzM9ljRBlqYWMaParqbunNn0Gfzi9J7MtsogrYuy9mcwuwp7jykmZjm
         7IAs4jM7VRzFipRQOAEHWvyy2L4QhNsz4olA6uPV56NkNIu4BmNK5ULBPtGrj5Stg6F0
         AnNk9FjJCQqWnyv3jXI6S2+VFjbJPm3pjQf7vIS5l47wdu++QAaeIFD80F1afMRrCgjM
         VzKWEeetq5tuBSlBoENHoUlHzNBnp2H9IY2z4AhmAr1TG4Ky6bU7JIOyzPuAWcdl7yY0
         U3d5Fr5uJP+lp2Q0/WyBc4FLXjGkCoOwbnw2Fwi+xhHD5gwcvdfM1s4XmqHJGrBcKrrm
         kEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748358623; x=1748963423;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TcDZQwTmMdtyKKt05qTa4r45+8RvNA2opPyhd5OidXw=;
        b=v6qtJZYwbAmHvYqpSAloeIeiR1GItOo4ZvPtVP0Sz35Sx3QqGju71vK/wqY3x07MDT
         LMOgS622Nk0IwpS4DggHVBBSILk/8T019/v4m9MIQl+xbifeSVaL2a5VploTXpXI2pfs
         Rmu/qNlkAdjvBqYNiZOH91SAZuAnM56Y2dEkEZ+okhhrjf6MIJroRFjdQ6Zc+7wV2o/c
         y7ASCefOrXvDljYjMWkaT4EUUv227m/T723QvQbH/ujeUw/EifBJDVIrso0Nm1KywzpJ
         tx2LThP4hsu4zZQYvq06LckJ1Un0aOCfLAUjuORYZAkqB9eZFmyJ72GoF7wod5OFthqL
         jv2w==
X-Forwarded-Encrypted: i=1; AJvYcCXnOYZ7xM6uPeNskg7ksITLKTabtMP5qfpr1BzldD59J61EeLqum1DdwtZqoBuWgYbhLJnISw1dB8BMTzs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzajucpslwXdueXaoChjeeauQOxhzJZNgDoOPU8LHVVqjO/5jtT
	u0c5uJ2E/eoLYy7tWFNqyaOI0ATDhTzG9RBsXu6/ualM1eU17LO4DGWn
X-Gm-Gg: ASbGncuoUqeGdZyMqIhpUEYHI7QBAQwRr/ez5pjVvo9R5/SWMuZumTwZvPL5JuVHLZb
	sJFZC76/UQ1My67u5rryA6LkwURb93j5d8eWZXCpHK2XwMsq26JZcboM1lfmsisptVozkuQSZMh
	0gAsay2g8IpEgA2cG0v3MZxEyV6XoOAxP7V5Hm0QGAWaZxelpcj0Fmc/4uNt504ncj+hBRaIjbE
	Kdg9E8CajEZyVjGOndINLnPJS/dH6Ap8/Sivy+Vd1kIHj+lXZY4XQttV/X4SsG3R1jjdwKiOu51
	oWHSoFjQYVBec00zJi68GNpDJC3kvu8qLZk7tOkSyO7iN0hd2pU31G7GrVMV3uzf9HwEGgue
X-Google-Smtp-Source: AGHT+IH0RFT0xP+3+dNVvU0bw/BAG60Nd9T6wKSR2SIUzdNr5GW2guXZ60yJdjSdkxe8OyWvVV66/Q==
X-Received: by 2002:aa7:888d:0:b0:736:4ebd:e5a with SMTP id d2e1a72fcca58-745fe0c7a55mr20646910b3a.20.1748358622652;
        Tue, 27 May 2025 08:10:22 -0700 (PDT)
Received: from dea88b1475bb.. (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96de11csm18869987b3a.31.2025.05.27.08.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 08:10:22 -0700 (PDT)
Message-ID: <6835d5de.050a0220.14ffd7.0e18@mx.google.com>
X-Google-Original-Message-ID: <20250527150946.2815348-2-LeoWang>
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
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: add Meta Clemente board
Date: Tue, 27 May 2025 23:08:48 +0800
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250527150946.2815348-1-LeoWang>
References: <f168126c-e0e2-40d3-9b9b-2a5002a75474@kernel.org>
 <20250527150946.2815348-1-LeoWang>
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


