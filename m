Return-Path: <linux-aspeed+bounces-1326-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E0EC67861
	for <linux-aspeed@archiver.kernel.org>; Sat,  7 Jun 2025 02:06:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bDhPF4sqqz305n;
	Sat,  7 Jun 2025 12:06:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749205694;
	cv=none; b=ilbWquBzWwnn6UTzjWQyo18KXVGwGQAiyxVN8JYFkMWtkaVJmuDW/pDZIPmPlHDlfmSHnKuGcnHky7PrPIaJNBkjKpPPe3SExbMYGZ+7jT+uduorsXLHF2GMqMjYeOV/ZpFwSw2G8V9UlTzczl08ZoP537RZ/XYnLlxIVMBrXDFwl8YzByrjb89u0zAnzJPDaALm1rz+RzMiF84VFpsMzruLvwCztcPmRhHX/35gLkd20T2+/gOxUax1ThgMe64v8ktHTEye3gNfuw/BkpL0OwCq6PtWPlRm4t+GjbhQO4IRkihOILMt88K/qju7GCp2nH/fA2fUoROp96NWYLh3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749205694; c=relaxed/relaxed;
	bh=f2k6QLhMs+Ybe7hFRFwIVvK0vEsmpmU+VkYws59KtZA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfWezldooR6b+i4FU436X+g9QGUX8tD3LhONNNIVYEp/SRhc4Yu7qIg62QVtr2VPcsjH2TlhiCGaNH38pxQ7VEglwkwfmdVQsxQpgPOSPf4NH0PlQrqtye2YLpHG2iGyLs+2v30ThuwFhSV8ku7cYcaIVVQmgnAzM4OU8KENvNeXgia+IvL2zX+nSqAlQczeyLdI6cz7Y0TdMKbila8iCGSIYUcXoLy7PXp0nWVeEV2lDDZpvTE3PgZ3DmFS31Ny89TpVCYD4dS2h2DMjw5zboHg9byIVHCdHbnv/iDVI1TkRgmQQQyhsJRrkL3+7ROyskZGGc3acVzfeM922ho44g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=V7602Xyv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=V7602Xyv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bDHb167hXz2yZZ
	for <linux-aspeed@lists.ozlabs.org>; Fri,  6 Jun 2025 20:28:13 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-231e8553248so20023045ad.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Jun 2025 03:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749205691; x=1749810491; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2k6QLhMs+Ybe7hFRFwIVvK0vEsmpmU+VkYws59KtZA=;
        b=V7602XyvDfffwi8s2H2EWD/jzccdjpc48g3p35XAHH/kWPgz3LhRRMpgQI29ASlTr1
         Q0wEMADXa+mhvby1b5cJXnMBq68M55UqLEg/haL4ojLyXzyPQ+UrsU248C4XFF93ToLt
         kj/uODWLZo683cRfBIxH65GNscHuzVmJEkw6Q/uNA1/+2JVheUVOtw09CZZYMaM+kygj
         b0rr4fTWD7j2optVyiNjNydT4Yf0qvx7VnIGnso7eCwuJ3TaZXuHoImx6CppzdN6Nwg8
         mpeErtERXpq1LJCbKWyPoK2fi+HfH6rIn0cW5tUZ0GFI9R8DiKuowVBPwtAbQyUz2Hns
         s3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749205691; x=1749810491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2k6QLhMs+Ybe7hFRFwIVvK0vEsmpmU+VkYws59KtZA=;
        b=X04nCg73shI3WajgSzjzZG0t4WWEbgQEvgpxKrXTRjxJ9VmysPciXMVAfzpDEn4OCj
         P/6UJJxg6s+vXj2llM1DK0hyu32eZvC87bLf67xtNUFIFvXhoOGNYwTmnaD8cMKDJnlw
         NkeFXT29iyBTMoIY/ENsz/C1k166Pvqmbbr7Kw+6SMGOrHQYmZDfZ0hNPi7b+lJvWtwN
         GWk3ScyK0MWFEmnWU6yTrY9nrKPfKIA+01OIHejD4ZOgC1NzA/dPxHUpVcksXZ8CVGnn
         4kUhoEUxz5c7hsnnSHrRibtvV//zDP6g9O4CsyO54bM2ygc7FPSNapAcGy4Bno1FuQ5d
         9+sA==
X-Forwarded-Encrypted: i=1; AJvYcCXfxoUvJ95uEPrVgfW7heM4nyvCwLNEdShsR9hH9Wv+eMKWzkQaDqPVGsTRTrQfi16NNFTH04e3oLEvJGE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy0zS53Ow6RnJ5Vqg5s36VvSRI7dZ93EthOuZgS4yTdiUlBzmeG
	8kMcGo/o0Teid/TBtUisDON7GNaCnJNOGawOQ6vwOqiIXF4elTI3KIK3qcE4W1tJkxg=
X-Gm-Gg: ASbGncviz0Cm75mozQoVFrBnso5mxMm4Ml8uxwUxO5urW3B7+KrXXt5Kz5auAQIa6jv
	rSdXphR7JDW9J7U9m7ZdA6+oCp87V2PFWVEvGn1jJfqz9HbZO56CzaokHv3ccj2FtINDPZynkHA
	25R9iqim2RxpWApTHZrGMimOJdXaozxo9I6f5B4efPEQcuUTln3Ch7haxlxomkY6xPgw37mqLVY
	0WO9VDFDiDi7UForsCZkUHngq1xs4TU33m4AtHd1Hj12YVRfdImba9s81RNIskDfaR7aJjTsQGn
	HdenuY9NEOmUFGlDCdq9zji8UpbyLP5+FqkNjKwqLj/gD1o2clT3AhAST+oUCvlbWoPEGGdz2F/
	dOXivbkQmww1wdtuSKCGBc3hpKBC9d3KJXjckArPqW2rHjRj9Sehu5IEnkEjzlv7NGnBmzfWI1R
	BIteG9G2nRjA==
X-Google-Smtp-Source: AGHT+IHdkRnMxTdMkIPYO52HyIjgNRpDvU7O4+2NT2FszwjIZ6VSApJKtT1r2YkGVF9r+aJyzdfHBw==
X-Received: by 2002:a17:902:db10:b0:235:91a:2c with SMTP id d9443c01a7336-23601d82d3fmr34529105ad.42.1749205691572;
        Fri, 06 Jun 2025 03:28:11 -0700 (PDT)
Received: from fred-System-Product-Name.. (2001-b400-e35c-06eb-80f3-97a6-ae1b-00f8.emome-ip6.hinet.net. [2001:b400:e35c:6eb:80f3:97a6:ae1b:f8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2360307813bsm9632885ad.22.2025.06.06.03.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 03:28:11 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: arm: aspeed: add Meta Santabarbara board
Date: Fri,  6 Jun 2025 18:27:53 +0800
Message-ID: <20250606102802.1821638-2-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606102802.1821638-1-fredchen.openbmc@gmail.com>
References: <20250606102802.1821638-1-fredchen.openbmc@gmail.com>
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

Document the new compatibles used on Facebook Santabarbara.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fb..a965f1a03051 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -87,6 +87,7 @@ properties:
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
+              - facebook,santabarbara-bmc
               - facebook,yosemite4-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
-- 
2.49.0


