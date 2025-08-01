Return-Path: <linux-aspeed+bounces-1887-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352BEC87FCB
	for <linux-aspeed@archiver.kernel.org>; Sat,  2 Aug 2025 03:15:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bv7Hb6YHyz2yGM;
	Sat,  2 Aug 2025 13:15:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754036599;
	cv=none; b=QWYZrLirsuOsQHC1LBUgAQ2VFPHX/N+FslwrEslmQ3YPK/TJE2xOMe9YVVl+YovQetPfMUIEVCdRwuC6crATd2tBVeXxXB7xr/2B3VQjM6X2hSCOm+ENPbBpQbkIoB/sxYhn0CVATF9rNt79MTjN6OHm25zOL0///D2FVH5yFRkyRFtJQR340Gg5Kj80iYz0dx/nGoRjGAf17rJqwOFtVRnIlh4vqRWDPT85rUtL6la3GXmFE4Tl2/++X7EgWKA79DJ0MWKkus7Ltvznjn+VVaIt/Cf70AVbX4rL3D/rs0JobANdbTC36hSjs6txtHaptfI9z7/IdQHVKSSDrL0jRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754036599; c=relaxed/relaxed;
	bh=KxTTJcqEHv+qBmIyyfl+JxjRyKaE0U2wO1Y0rWsQE80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8twXFrHNIforHhjZ4sn8ioDivM2IniZ2tKO1dPJf87P++TnMOntlQqAPQMUs3FxYwTqwU0l2q/4EqB9fp6cWFLtray2N4C93/oa6xK7xgqFZd8VXxbHNnbfOHc+k9z4xG1JKFXg26skfMHtnAoLTIoAd5nV0ekn6SxTo1mTOdKY0d2O5aHuB9Sj2BQSKtwhg3Z2qv/j3VBtQ+PnU2hkO9TCA0Lt6P2y4ivXaU2aSX0M/2VKKtV2k0DMemNZ3KuZzo6vst9/sDvJOj3hnRUdqyUjfx/7S5Aj2VccMR1XSm47uUPLlBBWfs4DDtnwM+d44BlHoG1+kS2bsU8edG24NQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cXQiJjD9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cXQiJjD9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btf926rLrz30T9
	for <linux-aspeed@lists.ozlabs.org>; Fri,  1 Aug 2025 18:23:18 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-31f3b54da19so1304005a91.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 01 Aug 2025 01:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754036597; x=1754641397; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxTTJcqEHv+qBmIyyfl+JxjRyKaE0U2wO1Y0rWsQE80=;
        b=cXQiJjD9VbOUTz7AJP+3MsVaYkFE8SXFWObswxRY5rkZMs31x9TBYD0i5pu/T2EJJJ
         7AGPhLCh7TiDj8mPN3BlRxM+ON+VXvdwByJimxGgEEapPmzohZlvm4+IDrSgaytLRG5F
         Ncl3OzDHv9XDoBRMGg/sy8oJKSLCqdaEhUAt48SjJehhiAzyLug2y39fLK0OTz2TuD35
         5S19Bds0R0aEwMjLXAGV1m7AdnSzt2lCvpzTfGW+LV9aLpbeoQ8Nsqr8kz7Ngb1euYBp
         inrHDi3NQUexdhyk5Bi2mPetFe4YBWjLfow3M51yXq9Kg8KFbvaEXcTX2LYcLFXS0SkO
         E3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754036597; x=1754641397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxTTJcqEHv+qBmIyyfl+JxjRyKaE0U2wO1Y0rWsQE80=;
        b=NjX+cfwqbnIRWpjEAEhvvDxX49wLmAE5VmYo7EiYfhi+Nhw2ivSR+/1Uf9ASUm03Ms
         ROfN3UkSViH8ZMuLS1BHSJ8w/ZwHGqfd6jkapbqT/NsIcYu5Dw9IRTO/a/SnJFJbiycI
         jVU9TCES9Wb97ndiltaHs2frhjVbgOA7M12jQrUgf8CahaQvhx+t6r8laCOirdc4R+lb
         UVvG1ztp5b6Gt0EpSzMLn7bjd+xyugjtCTZ/+CMQa4dPmBde/8x4BD01B332CqTWZ3X4
         ak/O27NYTKwFPPXgiwssagyg6y5UmxHqmvKhLaEppHOebGuCjY32BQ3S3KSNrVKavjRT
         NEiQ==
X-Forwarded-Encrypted: i=1; AJvYcCViy7sc9Q/HBDnTxN7yTYbhyAyL9Gw0zasPM8pN/DSfA3jfro6zkmOi4BXPaio0xOGjslwBxxuisHPMxWs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx/UplgQ4oQb/edVA1Ms5I1qT/toRgfNzvhzUOALi99++a7KJ5j
	SODt+BLjnV3/q52Z2l7ZT2EOC6j5w1LdRb66w5QuevvmHsYFCH95InxV
X-Gm-Gg: ASbGnctNm9eW8D+f7yyaIbqGjtIRrxAHXHDA4qsmxeIPi/okgvyA2SgjYKLNL6gLsGk
	QmZwBtiqEi+FV0ofBy0lW0yzwE3zCMMidAszkQEFiAIPkBk7HVMZJDVbXAJi251M3cw7PxE9AgG
	H9iptopZ/ytNa/zOnmhLVp2T9afpLtMuH/2qazCm/OOAGXlK6aV5pGJCgo85fx1KHB2Phy20FAv
	63KhxrHlVvafiz+73IreQif+MDLVlQFHJsvcmcAT1s2o0W8V1SWNMW2u9m2YACcCPTMewyRkaNe
	oAL/5zQpGyTuB5Yq5IsC+TOGvndpmKmkCd9yHEj1zCSrEkJCYdz1+3qibdCcPFB+FziEmtFVepk
	R3d3NeYU6MwTkJXFZeKfn31sXewr8yx/f1dPDVLNP1PffVAPqH4/mkc8XIETxk13ipEM=
X-Google-Smtp-Source: AGHT+IHLtttObr6RHLUMlfSn58gWBnWQ8BzmxATeW5ja8/S767K+9n/KyoKQzTRXAXlfXE6gGtutXg==
X-Received: by 2002:a17:90b:17cb:b0:30e:5c7f:5d26 with SMTP id 98e67ed59e1d1-31f5de6b82dmr13898114a91.24.1754036597066;
        Fri, 01 Aug 2025 01:23:17 -0700 (PDT)
Received: from [172.17.0.3] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3209a850417sm3992725a91.35.2025.08.01.01.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 01:23:16 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Date: Fri, 01 Aug 2025 16:22:48 +0800
Subject: [PATCH v10 1/3] dt-bindings: arm: aspeed: add Meta Clemente board
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
Message-Id: <20250801-add-support-for-meta-clemente-bmc-v10-1-c1c27082583d@fii-foxconn.com>
References: <20250801-add-support-for-meta-clemente-bmc-v10-0-c1c27082583d@fii-foxconn.com>
In-Reply-To: <20250801-add-support-for-meta-clemente-bmc-v10-0-c1c27082583d@fii-foxconn.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 leo.jt.wang@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
 bruce.jy.hung@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754036588; l=933;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=UnfBA/U+nB3GVshcJhQl74M74uA3eyzQykqLq1TeLXk=;
 b=b1s0dY3wOYlRo25bgL2yW3RNY+qHI7/86y7H7T8KzTP9Zb9gw8I3bewSY5hsNYMx+JHrCQ7ZZ
 9KoQpnFuP5HCVeQ6ga8sPILxNRyQvLe3FifzvyCLDcB+V/LhtjPANo2
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

From: Leo Wang <leo.jt.wang@gmail.com>

Document the new compatibles used on Meta Clemente.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fbb076582a6c0e801903c3500b459f..ff3fea63cecd99ec2dc56d3cf71403f897681a98 100644
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


