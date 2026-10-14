Return-Path: <linux-aspeed+bounces-5203-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEE6CCA46C
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Oct 2026 04:33:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5X8G1Q3Gz3bxM;
	Fri, 16 Oct 2026 15:31:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791966103;
	cv=none; b=DtY9t5WjDRJUmwo4KD8iXoiHiUk/4sER7PPwJq655RHugf+SsAZN54NvhB296uZpVxZhHTCv6PDMWTEyYrdb5++mEaa8nTwMmjmbvaIFzwKlaWeeqVIzzKhFqNWf2nWx0s2dHmHR75LCgKbTF3jHrmkfJPEpaSbCUv/kY3Cfws1Tl2Uq84jQkHfBN8OBNI+WKpYU+9s32d839RDLPkj+V+t4dtdtsmTTwr11JWKbkI2ZLrZwPRNaqfeh1NVuntscWPO9djjK7FwvVqPDpShDfg03rw3dgWx+Ctg4jfe8YaDYKEE94Io/dNoyhPCKXFm6YcLBjFjX7So2CFuvk2UZBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791966103; c=relaxed/relaxed;
	bh=Z6y7j+G0zmzgPrQrrwJmak2jWutCzC5yma4ucK0cyh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUIcpJIlURu/knV5uyv3FuvqZxTaQtci/MBcb2qxdbPs4SFlN9PeB4q75oTRZBt9z00meGvovtr18qoLJ7rnH966B3P/LpdGN7hdSaVyzFkOqbFLp4jD9EdlNHHruZ46AqmW0w/9ZKXNVoVBxofZSLQB9My7grDAGXJY0WYsMDd08x/Cmc21lQ88260BrB0qSZeQvW6xRcIVW4pdu3HTmLzeFn0R12yvDumM5CAaEM22+vd2Q0tRd0KJ7Q6GO9u+WYuMdwylpK911C+rBZKIn01rQQL2Wu7hXtx3HgnS/UlUgCeFlil529YqOkrjuqLTto/HNLRnLfx5Bjcs766Z/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KhwWkNtD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=wenst@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KhwWkNtD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=wenst@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4PLZ6Vf7z2xwM
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Oct 2026 19:21:42 +1100 (AEDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so2819964a12.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Oct 2026 01:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791966101; x=1792570901; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z6y7j+G0zmzgPrQrrwJmak2jWutCzC5yma4ucK0cyh8=;
        b=KhwWkNtDLLtJR12eR5XBv2QFKf1xBeUxUS1Mo4ED18Rssob6bo1ZvC4kOu2Ek+c0PB
         XmFyCXh41dQ/HYjhjEIMPHfcgKT7oRYi7LqHXC0DZKbUk3I7zaJDIQdpKxtnljhTjOAQ
         lMNzaq8gCP0+OQC4IVP2lnkGpTDXpdlcIKVF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791966101; x=1792570901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z6y7j+G0zmzgPrQrrwJmak2jWutCzC5yma4ucK0cyh8=;
        b=yD9znDeBPpDa/5y2sxjPgM8zsoobySXC/lk/IkxAFFbcRXNj0uoim7PnRlxRAIqBd+
         1HLHHgb5CzOWryeQQj+R0j6A60uDz5D+4baMLGfpAltwtYMabQbGKZaGEScOfOmPn4UH
         UCjbwJ5z6YC2TiQ+xmzAbrGazxeqvYPgmmMSr8TIZoPTBVgpsLQz/eTd8LbKwoZJjMhh
         0lOzVPokDKR7WauvZ/dsp67AmEQ/q5+zxk1vfdptvzF78jQw6PGgeSZu3U5IwwARwONE
         PD87Ac1sYv/ixe4mdjmQnloFmjwdKHB1mnFRgnqn9CFWYrWYlHQN2X9wV8pJdAhljX5f
         M+CQ==
X-Forwarded-Encrypted: i=1; AKwUvBzX/pOvXv9mct1gF0lU5n2+ICNEQDQb9fChIpuQ6gqc1tQFR/ne32vMec8GH50dg4egM+fvUobTa+nhXbw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKPLtousyQjpaR13YzkiRs7WeZduy/Eg5NLTjiiA5LdpIV1kQzC
	JCV6clHKAQHpiUZ2y96Kl7nlKLSmkNJuf/Jw4rOURfe/DjtCScp9EHXy+bm0VmMJUA==
X-Gm-Gg: AYBFou03b489Wva38sa2oavidLZFBF6aSCn4ECItUMVn13DnpVDPZPD0a8eE6YIzSQy
	B3/Ck9v4oOAi8p5CVPx1nqmlZYD73gT4MHm9W7l5qfopft0APOzToImkOeitMV/3MkQdtaa2hM7
	PJviAl4h/TrnJyOHAI/n7UWFDe9lddRRKfpsp+Wpjc+mexFH/QLrtAO17pM+mqPE4zA88Fanjbu
	3lRTkAIP3ylNekJusXsnZni1Oq7A2KWv3F/JUzwlddP4ZgSDmpx4w9zNMwn+Ccs2gmJ/0vUNdK+
	vikJRhC2Scczuy2BU31FyW6LImbPdY9u6NcP5UH7h5u8feeWnhX3Rd0qM9HroOMK49MtUri36/V
	WlPKyYViUXcwF00QvNP3cSPONMWG8AgoB55LR0pqgUi1x46j8AeR6Zt/yTdO9hV9JUS9J2BRST3
	QhbkHYhA31QF1Lpz2iY6/KhIrfly7YjcFmnSsyPLqNS0a9EuHyKWvgDB5NRzEk2qusW8rSl4UMK
	yzrtPhbRwbyUyXHE46Rp1OTo4jld4hUqgbQrIo9WutPZMECEyoAA2zNEw==
X-Received: by 2002:a17:90b:1a82:b0:3a0:d82b:237b with SMTP id 98e67ed59e1d1-3ab3ab209f3mr7706681a91.25.1791966100501;
        Wed, 14 Oct 2026 01:21:40 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:373a:9eb7:c5ba:7b5c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f04e324sm3682141a91.2.2026.10.14.01.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 01:21:39 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <balbi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Michal Simek <michal.simek@amd.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Wei Yang <yangwei1@eswincomputing.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Hang Cao <caohang@eswincomputing.com>,
	Li Jun <jun.li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Roy Luo <royluo@google.com>,
	Yang Xiwen <forbidden405@foxmail.com>,
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
	Robert Marko <robert.marko@sartura.hr>,
	Xu Yang <xu.yang_2@nxp.com>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Stanley Chang <stanley_chang@realtek.com>,
	Ze Huang <huang.ze@linux.dev>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-aspeed@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: [PATCH 2/2] dt-bindings: usb: snps,dwc3: Fix downstream port numbering
Date: Wed, 14 Oct 2026 16:20:36 +0800
Message-ID: <20261014082037.1774672-3-wenst@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261014082037.1774672-1-wenst@chromium.org>
References: <20261014082037.1774672-1-wenst@chromium.org>
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

The DWC3 controller can operate in host mode. It does so with a XHCI
compliant host controller. The XHCI has two downstream ports, one for
HS and one for SS. USB downstream ports start from 1, not 0.

Reconcile the downstream port numbering with the common USB host
binding, renumbering the downstream port numbers from 0 and 1 to
1 and 2.

This is non-backwards compatible, however it won't break current
major implementations:

- dwc3 "gadget mode" in Linux kernel only requires a connection to be
  present; it doesn't matter which port it is
  - dwc3 "host mode" OF graph connections aren't supported yet [1]
- FreeBSD doesn't use the OF graph for anything
- U-boot doesn't use the OF graph for USB
- OpenBSD doesn't support dwc3, only the XHCI in dwc3, and doesn't use
  the OF graph for USB
- coreboot doesn't use the OF graph for anything
- Zephyr doesn't support dwc3
- TF-A doesn't use the OF graph for anything
- EDK2 doesn't support dwc3 and doesn't support OF graph
- OP-TEE doesn't support dwc3 and doesn't support OF graph

[1] WIP to tie OF graph port node to USB port device

Fixes: a33113f73693 ("dt-bindings: usb: snps,dwc3: document HS & SS OF graph ports")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
It is unclear to me whether the HS/SS numbering is fixed for all dwc3
variants. I checked Allwinner H616 and Rockchip RK3588 and they both
have HS as port 1 and SS as port 2.

This also doesn't cover a potential "multi-port" DWC3 implementation,
which Qualcomm seems to have.
---
 Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
index 6c0b8b653824..4b6304bd2ec1 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
@@ -410,11 +410,11 @@ properties:
       property is used.
 
     properties:
-      port@0:
+      port@1:
         $ref: /schemas/graph.yaml#/properties/port
         description: High Speed (HS) data bus.
 
-      port@1:
+      port@2:
         $ref: /schemas/graph.yaml#/properties/port
         description: Super Speed (SS) data bus.
 
-- 
2.56.0.212.g129ede20d9-goog


