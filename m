Return-Path: <linux-aspeed+bounces-5204-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084DACC6B2D
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Oct 2026 04:33:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5X8G3JLXz3bxH;
	Fri, 16 Oct 2026 15:31:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791966092;
	cv=none; b=PybjdAw9Z2b270q7oAQeaYkcnkrBjdv8WHqjH4GWjmag7XSMGfiyOjhGj6IKz/NvKHj9EncIdCiQuDjoYShqMdZ5+XxZArbGrXw4sYtEa9wiBTGhYikdud4+E2Vo3rdYGXOR/G+m1GZI/nGu4t0K44/X4G/eTkaLihr4yiig8EyhCt+C7r0y8xLVxwGIM6W7SQah7tcPJmHYR1WsPgzHGO7XBRkpMd2kk8vfP8MlW15B7GxAKvYKgzTzC3CJ7D4ILDA9tcPd8dafn6jLTJTJbRWtdanKIoxNMi+isdPKxRnNmSkSDGHu9GqKOpguutqiSUuOG8fs9+L/rakbYgc6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791966092; c=relaxed/relaxed;
	bh=yVCZM5zURPRE62cvJS0zNIsVrphYetwj1gaMWhP5efk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5xPHs0JOlsoVYwu1JyWs6RxpHOtJLtz3ae5lIficTY7e+2rBoHP+eKnB6xTdf8ZZpMVytrYUSy/+ddpthAJx8DX+OEv9wv0J/nNypaXJGP8eyPgEPb+hYdJSUYfM2wPgAY7l6AVpYeKdvDSyhc1qyOve0lfF7KD6rH/Q2mG5NXUxftMlpDdAZoirtc8C4HvPd+Zhg9Rb22QqG9FMOJv9rjU9b1tHkW/4k2c90RCVJF+cyFc9FclJPyT4U/cHIM7j2+/8po3GYXo9YQ0XWxHOPwtOyK/cUhUHucOAqz22CymBHhuPZYx5LOVJz+poxHoi46YxGu4deD1R/CYElgQkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=K4w/RLbJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=wenst@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=K4w/RLbJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=wenst@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4PLM3s0Kz2xwM
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Oct 2026 19:21:31 +1100 (AEDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso94463a91.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Oct 2026 01:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791966089; x=1792570889; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yVCZM5zURPRE62cvJS0zNIsVrphYetwj1gaMWhP5efk=;
        b=K4w/RLbJe9hH+MitPakqSO/izfkPQJ4uB5wpPqfJ2TZIYtMQt52Cj9XwSNnluyybMJ
         fhkYGUnmkW/Kf7X6L30/EdEgZe07kUH33vz3RpkSOaNEBlGzLujGZbpKQnSI4J3Xfp+p
         nR2cfvlGDjUXoT0/+pkE88KoZEYaHslwefZ64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791966089; x=1792570889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yVCZM5zURPRE62cvJS0zNIsVrphYetwj1gaMWhP5efk=;
        b=M4DqbhGH2aOqnX0LeNeyHNCDGQ/iCLGipnmsYG3699rRduB56OMplTMSxi1VmhMX6a
         XG9tDn52HtZzUzbdUnCoYfqHVoTDIjkw1nc/JvznaNAYRnvlEQIXzqUjaQQxP2bzZrJQ
         /rj0VsXCYjGuYyfXRtXU1PceATylPyV8nRdGNTYAeuuUtf4r9kmFsXM9jzNSnuF8EP+2
         ozsrHqrMW0uNra+Kk9AX43LzRnnHwB+HfGlM9m2dJb6sSmTQq85ovGtn5zRH5CxKe2bL
         sQXWatfET7cp8RPBfEfmzHOkhipzz3j3d59/1l0BmNvL9ABOOx4MAq5G7Q2B1p/z8Xl5
         VIYg==
X-Forwarded-Encrypted: i=1; AKwUvBzovLkry38FTgRdYie9I1HbK+gKhqqmaMAIaiOXiAlJbLgKZ5G2djvywmJD5g5LYb8/uaMEtP9hBoAjm9A=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKGaWYQtR4W7C3/6BCZ1p9pvfDciEhvXIzT99jyJGgYAoPj7q0V
	XCS0HxOrTXengyoRi0YH4D8v/KApfDMBtDHnqjn7j45k8XEQk7Uox8qAV9z8+/gDTw==
X-Gm-Gg: AYBFou3/IxPSKP/dx4zKsQHdU8i7m228Q/z19Onl5GJFhlKD/+7hoXQ6R4Guum6gPpO
	4gyWxuU6vVI/GrwflwilEUjEkrCJ/6iTdJr2gOARZiRT+Rw7IzpztIX2dRCaXZv4hS1+BCNJMW1
	awKlIxYgf+TJNWTVJJ4FzGYvmb3ffLXkJqOILQvp9A9GOEPqBPDJXvgz1i4HfRMesW+QHmqU1WY
	3KgGxPxbAmz5TTf3KjTrNUAGfUTFq0QJZdfwy4YvAXNdCbNx/irkWvDXwegWWbkB1zCZRdR4SJU
	cYet2B+qumwAQdNWZvPEDTdMsoL9XhY+zBdaVrl9IzQV3ivFzE3M/S6+ROMXbRTebs6AKE7W1Q7
	X9qEbCjzqc/RAU08I2lCj3BSFT1TzNBQzWjMGyaxsUUa4jX4G6kIJ6GOXqLqbNgvMIc+4W+UNUV
	0db9kIntbUHEdqmLGX3gdHEVxu44lT7Q0eT2Z+Z9zxriqT7zRi+4vh+X7ikLN+zoMcrovyh1krn
	Z+oKj3+4fe+RfYhFkc8cBmSmy3/SL4hcVEyssLQCDoEylVmQNixJkni3w==
X-Received: by 2002:a17:90b:2b44:b0:3ac:7842:bd50 with SMTP id 98e67ed59e1d1-3ac7842c19bmr520798a91.15.1791966089278;
        Wed, 14 Oct 2026 01:21:29 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:373a:9eb7:c5ba:7b5c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f04e324sm3682141a91.2.2026.10.14.01.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 01:21:28 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: usb: hcd: Add downstream USB ports
Date: Wed, 14 Oct 2026 16:20:35 +0800
Message-ID: <20261014082037.1774672-2-wenst@chromium.org>
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

Besides hard-wired downstream USB devices, a USB HCD's downstream ports
can also connect to USB connector nodes via OF graph, just like with a
USB hub.

Allow a "ports" child node and describe the possible downstream port
nodes. USB downstream port numbers start at 1.

Also fix up the address portion of hard-wired downstream USB devices to
match.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 Documentation/devicetree/bindings/usb/usb-hcd.yaml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-hcd.yaml b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
index 45a19d4928af..24df99dfb243 100644
--- a/Documentation/devicetree/bindings/usb/usb-hcd.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
@@ -29,8 +29,16 @@ properties:
   "#size-cells":
     const: 0
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description: The downstream facing USB ports
+
+    patternProperties:
+      "^port@[1-9a-f][0-9a-f]?$":
+        $ref: /schemas/graph.yaml#/properties/port
+
 patternProperties:
-  "^.*@[0-9a-f]{1,2}$":
+  "^.*@[1-9a-f][0-9a-f]?$":
     description: The hard wired USB devices
     type: object
     $ref: /schemas/usb/usb-device.yaml
-- 
2.56.0.212.g129ede20d9-goog


