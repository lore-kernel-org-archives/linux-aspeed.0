Return-Path: <linux-aspeed+bounces-3142-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68319D6E2AD
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Dec 2025 16:18:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dXG7V3L05z2xrM;
	Fri, 19 Dec 2025 03:18:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766074726;
	cv=none; b=ce2hQrRM92xG94T92RlRgvjeILLtPUVedQFqN9rj7OqJcYEY2QJBSIdJhxRL0wuB2ZYKtQa4r+VSDyOMeJWTodnVSszhu0wp5MyEC+rex6Sllmb8HBWLJdr1d458e5266yuw6aZ9U3i/rObCMy+wWB2Lazo356CTRVjWfPsbkk93xQ7biS/+bn50LtUHyruHJjRpmC/IbRJHWUK5v1WZj/ek8Xlh5brHLsmHo0Mchw7GHLoihjvQF7gIzq20iVzXTqe8jRzg0f5qQq+jQc4RJQFIXncL0r65JochqM5Faswffd2Fo9UqfgfvIHYfguYU7IIyUGRkgtMNz8/qFyBtmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766074726; c=relaxed/relaxed;
	bh=90EkJ5+JSasty2Ox2DkIb86KfhrQvUo5LvvNkx1CT+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9Et3lVmCsw19EvKSuwRpumKW4TO9mKHPCYYeSiQCjnMUFWZed0o8RPMEfreWd4TZzJEupT3QyrU1JnoNtOPbg0XkorwByFbj8rYWT4aCte+zswa+Cwh8Mi45CS0S+2TzV26vtF6jNgEPgsrKqTVD0fsiigN83p79X7PmvEKg02yQJsE3Dy1CBQHUbEeGLn684RWXdZDr+522jxps4M3dOQmgrOz0wlSepq02La4IkSHw+DQ2KO5Bj1oKIw0K0dY9CID2CMKYZ1n+qhq686myvLN9ONOaetfiqCJ/UuEe0u0fVmYRFbon4ZBRE01kFQpuXnPpB7KfPcS1anOaEueqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=zIL9ya0v; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=CAk9VeZS; dkim-atps=neutral; spf=pass (client-ip=202.12.124.147; helo=fout-b4-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=zIL9ya0v;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=CAk9VeZS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=202.12.124.147; helo=fout-b4-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXG7S54Slz2xqr
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 03:18:44 +1100 (AEDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 9FDE71D00035;
	Thu, 18 Dec 2025 11:18:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 18 Dec 2025 11:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1766074722; x=
	1766161122; bh=90EkJ5+JSasty2Ox2DkIb86KfhrQvUo5LvvNkx1CT+I=; b=z
	IL9ya0velw5A/ikR+s61JvXePsua1pwKt11zKzpIn6uwQuI9HqURyaumROPou7qL
	tcQn6kdwaZ1RLWoywYCFx3WBPjaU/YcJQDCpJnWUBTDY6/wimlFjAj7ZUrdA/Di1
	Bpod5AWUAIlxMLb13v8/RJuv45ZZM1S7NX87qI5bF/WInFMQGVbku+Qsp+/l3yee
	852xNCPON+3MtMBs4qHKd1HGjBotiLxwAL04lERk0nzsALw2KkYgp/3B0lRvv6Nq
	sdKSxYANK9C1CBDJW4kpXlYztzYHXNDRcpoybWK4O14u9zc4/0IMvKAfs3ZJ223S
	m5Z6RAH/sOaDfb+vfxFxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1766074722; x=1766161122; bh=9
	0EkJ5+JSasty2Ox2DkIb86KfhrQvUo5LvvNkx1CT+I=; b=CAk9VeZSSffk5LQgI
	OYRg8aOI1kc88sLTQQk0ZvowUTasfYYmd4/aHGtWz5PQHwOCgaK1nVKMdnooWFdz
	5hglLAql7tdJFFABvWZc1LiLYl2ALv1Bq9Jaqch5gzpRORsDvBZcIO5y97W5+JLH
	GLQY1QxMJFQQXBtbFoO9iVy8Gm/BFKHilcPHk0jCInGYLwFtq54nbFUvwgeLeHiB
	nduF/kJh4zfcuXGpUrXWq4j0pITf1OepqvPWUsLfTtJ+CPa9GkK52cz/mQRgRfba
	YM9QEQ6lcZ139voLqDEJD4zWZBEFjZFj79WnWEc3AphPwoN17KQYmWjMaouH7g1V
	ygdZQ==
X-ME-Sender: <xms:YSlEaUJekzXyBXC3xqYudsrNKasp_cL5XMQ0ZJXmNSIXz6ZnUamZoQ>
    <xme:YSlEaTutZPVQdvrw6TlvlXL51JX6gWfRhGXPGOCjafUlwDnT4VH_s0Iv7X845upOy
    i6vxaTnBUVUj3hOWHTvdVMDnJEIQZLy5raadVUCdAvQH4SEMS3MYyI>
X-ME-Received: <xmr:YSlEaZBXYK6iCBTOUjZkG-bKmkL4J__ehO_kc-qdNHoUZ7ZUlIb6ivKOwHfs1xvroNnWzLwJvvO7pHfm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegheekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftvggsvggttggr
    ucevrhgrnhcuoehrvggsvggttggrsegsshguihhordgtohhmqeenucggtffrrghtthgvrh
    hnpeegffeuueelvdeggfdvvdfgtedvudfhfeekudekieektddukeefteetieefvdelfeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvggsvg
    gttggrsegsshguihhordgtohhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodguthes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghupdhrtg
    hpthhtoheprghnughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgt
    phhtthhopehtrghnrdhsihgvfigvrhhtsehhvghtiihnvghrrdgtohhmpdhrtghpthhtoh
    epuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtoheplhhinhhugidqrghsphgvvggusehlihhsthhsrdhoiihlrggsshdr
    ohhrgh
X-ME-Proxy: <xmx:YSlEaT4oUaf6OrCTDrcxuvosMyUI3QNMpXlQzIJC43j8jCRL4Jw_eA>
    <xmx:YilEaZBnmUet7Uwb8wZEe-SwWE7XhjA-TGIG75O8YdwPFS0Io20Kxg>
    <xmx:YilEaR6NUS-_ODqFalfBDnyWmRAzI2zhdocy58dhf_rvo0dmzoiRfw>
    <xmx:YilEaaup8DKk4f_gkYI6d3SuUWmi0AUqUMXtC833UHZ3blHlGNz4IA>
    <xmx:YilEaTTopnG1qjTLmhh0lP6bWJl2Q0ik2gVA9K4BNXqXnJVPS5z7Hjql>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 11:18:40 -0500 (EST)
From: Rebecca Cran <rebecca@bsdio.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Tan Siewert <tan.siewert@hetzner.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Rebecca Cran <rebecca@bsdio.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 1/2] dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8 board
Date: Thu, 18 Dec 2025 09:18:13 -0700
Message-ID: <20251218161816.38155-2-rebecca@bsdio.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218161816.38155-1-rebecca@bsdio.com>
References: <20251218161816.38155-1-rebecca@bsdio.com>
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

Document ASRock Rack ALTRAD8 (ALTRAD8UD-1L2T and ALTRAD8UD2-1L2Q)
compatibles.

Signed-off-by: Rebecca Cran <rebecca@bsdio.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Tan Siewert <tan.siewert@hetzner.com>
Reviewed-by: Tan Siewert <tan.siewert@hetzner.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9298c1a75dd1..aefad2d02993 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -34,6 +34,7 @@ properties:
               - amd,ethanolx-bmc
               - ampere,mtjade-bmc
               - aspeed,ast2500-evb
+              - asrock,altrad8-bmc
               - asrock,e3c246d4i-bmc
               - asrock,e3c256d4i-bmc
               - asrock,romed8hm3-bmc
-- 
2.47.3


