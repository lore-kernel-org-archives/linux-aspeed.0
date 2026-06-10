Return-Path: <linux-aspeed+bounces-4210-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7AFCD8CB9
	for <linux-aspeed@archiver.kernel.org>; Wed, 10 Jun 2026 02:11:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZq5G1rL6z2yfD;
	Wed, 10 Jun 2026 12:11:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781054452;
	cv=none; b=e0LPbCzgWGTxv7QyUtBZ07xTF3ZhpuAWEj1zX+sdi/x/zzrWIaLDmAI3J3Ef0E3RUQs9rKsgIVac3n37vDsuYTjkRrnAeIPUTVuXTzna7EGOlopLahy/vdWv/vai01r8zgpIWvz3p9FBp2+qVCmrp4NKTcHscEQj2Yd8MKn7XxUBijIL31grZ4HCtDCOGw35P7+c8oAosCOLrmrptLYfqyYNA3MVHFn6nSfdh9T//ZcgNwlVmRRdp35o5+VmkumK+jEFwSUCOqSKiPSTNw9Wc/05mvShZglNL3rROi4DaDdJqxDl9eFrFvoGZH13KR6qIFk/4bck/K7U+XNh5ZaMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781054452; c=relaxed/relaxed;
	bh=ctvKOED8Rs2Y8iHtAz2kdUCrMqrD3cqKZ8ykp6Je8z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQNdEdnaMKV+Yf48PJYQBc7IHNjdnit/wQ84a5n+rreUh0HZPy3Edy2/5gHqBV/mMlIArHfnNVENucxWiSRpZdtec2msgMmzvQ45lxM/jqElXX0UD9WdI38N0XVhaGndBTAJ3ovA7xy1Kz8on7/eWYcGdFLj08+450xJ4RwuSI5/rHe/yGwzqx1cUD3IKp5xaEb13wnxP84L/MsAeuGi3FN5PW0EcpkuDaKrc9jSvuTm3+cDwWEwX47qbpXcLarVzKf4/5EgWewelv5dYhvDYgNDbbUYiifgkYEcF9iaFdnb+nHijeyYYTo4i5j6ltu00/H+Sqw+pWKH17Qz2yYtug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ndxXLgY2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ndxXLgY2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZnz82HZxz2xjN
	for <linux-aspeed@lists.ozlabs.org>; Wed, 10 Jun 2026 11:20:52 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-c8588ec1b44so4246799a12.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 09 Jun 2026 18:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781054449; x=1781659249; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctvKOED8Rs2Y8iHtAz2kdUCrMqrD3cqKZ8ykp6Je8z4=;
        b=ndxXLgY2HZIZJCytPpFLbbHftWDpnmQ8CByHbTzbIQt4IZGs8kHmqyzVKoI+qgu6Wf
         ijaDSptyO7JaY5/WLnd1kmAJKmR1jRLTj1ywZvpv7Gd3iMfdKIhImq2YNZsndjjAlcMb
         Ulkx9snQ3o20jcopNAEz0UWMBIcLxzsWs5h6k1frFhpIvvNYoAvD5VqSLfr+WqlgkzaP
         Du22QWc67ifrDb3CfyjU5vfLgsu3+ZGfwcx6l3f95gdL5jY9PWsnONtBsrvv6enj7FiS
         09jhx6vdsGvJg760lGUSprEkqXBGkBd7gZtLYmNn3UfGM0Qn1nHLhjPkzu3jLQ0cMGu+
         EiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781054449; x=1781659249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ctvKOED8Rs2Y8iHtAz2kdUCrMqrD3cqKZ8ykp6Je8z4=;
        b=EgYXq06FlAtpz3r8akFMfhaSt0aD1WyGJ509O/Z/kaOOIetPERIriYkjS29Bwl9H8K
         0bjZpKzzR3/vc649LNk0p9f3EG59v18MrBV8SC1FYICxFvDJLwY2FG3A4t9fnN9GINNS
         CmSQSucHjCSoxGOl0qumSa1d0PWQt/23XphFbq4KwHoZ/Lm7groATyblNYP5crhYITBf
         9mGJyKo0OKEfKq9TYAs3a1CEJ1ZzSag1lNh2QNKa0LrO0+0jloeyNqnO4Wm+QIYqzq71
         ccOQsl5aVO3HsBhB3c54dUTIqMFRf8fZX6hdCNm6apRjoWQAfenHjv/Unu8eetu32zWr
         9j2w==
X-Forwarded-Encrypted: i=1; AFNElJ/sXC+dv2lYVuMmJeQOTSPMtVlwX7IpaZoUtkBPpRuBUKECOKzUSRzeisyJe4YuTKxiAO4oqfl/5/anAyw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzLyOaP98alSfMlCTDJqRG4ik0HQdJd51vzdPMr+HeTesRjjpWp
	9osbFbjDLmHGrpVRBlWxhGKaZNZesteJ0ANH/xLlR9YFRnMqaErVBGqM
X-Gm-Gg: Acq92OHWATWQNYhK9AvVl1eWvUgXXCba4Ow3lzil5xGU7eP5Iug+3t96nYO+VAujCDE
	cWFd9Frz6MMPtK6Ko6Nff/W6mDSmcg5rA63Gkc+puAMzBfxdHb1ukgNSDEEQiUa8QPCpOW3FjiU
	Obwqbbaqs1udImuymYtIebFq6Np7vSp8uVXO98H1y3UvEtNFcy20VcpUHRVUdSUpYZ1/qYeXh0r
	FZdzeEjBWKcne7751Z9LPj929fG15s0xYomuT6htMRCwYaFlRlhqSF/RZ0hP8pv7S86cixJl7lf
	y/UAGr21rAPk4svWvRRL5SlBmPIvEKfHK4ek0GDeEcnyLREpijIGbJEsXNnuYYdcJ6mJ40L3Rvo
	Y2g0zpFD2rFrxCoapGRkYmMu/EuNSWHyvFkxdaBl8Qk6DVerfb0I2K6Kh7PwSdLXn2qID2dIAq7
	39eHzM3bn+afC9S0Hgwfy3DkQgpFOjazst3G7h5/FbaCDDeQaavQAugBUTArWwC5YDHqO0KkcNJ
	Din+HZrKToo
X-Received: by 2002:a05:6a21:730e:b0:3b4:cd6:891 with SMTP id adf61e73a8af0-3b4cce1eb3dmr27487969637.20.1781054449584;
        Tue, 09 Jun 2026 18:20:49 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b2ddbsm18858370a12.24.2026.06.09.18.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 18:20:48 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 10 Jun 2026 09:22:22 +0800
Subject: [PATCH v6 1/2] dt-bindings: arm: aspeed: add Meta ventura2 board
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
Message-Id: <20260610-ventura2_initial_dts-v6-1-375d8e9d7ebf@gmail.com>
References: <20260610-ventura2_initial_dts-v6-0-375d8e9d7ebf@gmail.com>
In-Reply-To: <20260610-ventura2_initial_dts-v6-0-375d8e9d7ebf@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=909;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=J3z5h5jN99f1BFk7jnvt5xoq1tLRgjc3X0kRzaksvsA=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqKLxQQGomj/MY0QPBIqzFE4b/nQvxy7GBQecMU
 jN9+PGGewqJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaii8UAAKCRClg0K3CVbE
 gdXPCADAy73/bW+SdL3BxXS48kI2micWMc77f0hTPtW7/ARo38XhPrad/p8y0qxLcx/U9E1PmLM
 ysqm3BOxFtkQfLPmWBl7TwNquRhFRZ+thPHif/iPRp92Pi5q9SGl6F9qm9PzDzIrWPCpytgdrCl
 xsQVS6d33NSECbhZaK9tFT3Iae8PDyqdVRNYtt0liewHKki8wtcdpyecfgxLHWtpeCOsYEesl5M
 Gkb9Z8asnU9gEwDT3EUuoX0YA8PmltZEP6QfCZ/VB3ZnwyT1Tx3BWwpq8gbjXR5vZqLxENxqo/Q
 plQh2rV+g3b3WkjimKy8ClF/nhg6n2PtbzF3Cwe3JVklbb1i
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Document the new compatibles used on Facebook ventura2.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9298c1a75dd1..d48607c86e8e 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -92,6 +92,7 @@ properties:
               - facebook,harma-bmc
               - facebook,minerva-cmc
               - facebook,santabarbara-bmc
+              - facebook,ventura2-rmc
               - facebook,yosemite4-bmc
               - facebook,yosemite5-bmc
               - ibm,balcones-bmc

-- 
2.34.1


