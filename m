Return-Path: <linux-aspeed+bounces-3039-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F566D216A8
	for <linux-aspeed@archiver.kernel.org>; Thu,  4 Dec 2025 22:49:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dMqT04lKpz2xQ1;
	Fri, 05 Dec 2025 09:49:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764882185;
	cv=none; b=cigmyfLQhe6G5/3W9yFBG0mDnjZ5tdbiK0oxgXwYDk7202/yoe/SmUkFc9WHWgNPA7TNI08xJ6Uu0AyBxSbR4m0Xr4yYFDTWAB8TkzTVd+m3bo2Y6/cWS4smuUE9j+lwBE8d9K1vbFoMs9pXPQW8x9sJkASQ4/6C3GXfSlYMZFyvOxhu5DYOkC2DZ6Xi1HP8wHd5rPNXZzYVJ+lROSmwyJY8gvZ+MSuB5elmjNn9y0HzkvX1KjgP0GHpqcFwDQy0+VJrdbJhKXobhzVRNargdqYrjf8W+YKsmK/MkpZZ5TFYzove9Uv49+GrAFxAS6FRn1JOtU3oUcuzH11HGP2X8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764882185; c=relaxed/relaxed;
	bh=HHTHfsItrpNksp7sM3LM7hcMpvoJLCi8sr+Lllv2wBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOa1mB34pvzlM4WtrQsiQpRuPdmX2ahDWo8s9Uoql/VW/juUO1sFGS5RG8oVrlXn5uyshgXg55hMudxwIijt/YQ5WDctVxRuNFj5xKtxktI1d7QX9axzrG4uLfzCO5HwQ2Z63HW4Rcx0/UMmf9+rsSjCXLy9+WwB3rIlVIcFBo1G1f0GcI0MjS35sk7VLNmjQI0zzl0q3TyyMsreDS+Qp5p5jpLI5FWubV7onagh92zDtcC9JY9B05g/azYHHPOEJVrNqsUCzezdn56WYffy8C9YjvoX/IAE5S2u9qfm2bBYNE+ird9/6G7mcYm27TeblyJscQdoijqQCrcytlENTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=sSt7vwb9; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=PJuTbZbN; dkim-atps=neutral; spf=pass (client-ip=202.12.124.153; helo=fhigh-b2-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=sSt7vwb9;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=PJuTbZbN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=202.12.124.153; helo=fhigh-b2-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dMn604NqVz2xGY
	for <linux-aspeed@lists.ozlabs.org>; Fri, 05 Dec 2025 08:03:04 +1100 (AEDT)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 243407A001F;
	Thu,  4 Dec 2025 16:03:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 04 Dec 2025 16:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1764882182; x=
	1764968582; bh=HHTHfsItrpNksp7sM3LM7hcMpvoJLCi8sr+Lllv2wBU=; b=s
	St7vwb9LF+3aNcEGVg0EOHJZ73MaDi+clYBmAuc6rJ2wZ8D7TRFIBJk0CYzhW0nI
	1/yZkIYbFPHOTZXxG3aGaTlFq1tQ97tPiLlJZ+yNJblMSKNPoL3R7Rn/FLW+De27
	AZT1w7Uztgio99hO3990Mnlca9TSsGKMKde1f5gHrlTbB+2d3t/xT/+kJdGFkVv8
	LETWPekGYW4Esmk0NVu2P0y0CTWipqWqD3ETXrBZnwGTt/KfgG85/lPK62knnKEP
	Ix57LoUxcP4B5+5Z3Ql56jr1jCHWwJflgRa88jeXzokYszVv/EHBY1LPRXjT4bmv
	UrUCFjBujhGvXlw+Wn0yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1764882182; x=1764968582; bh=H
	HTHfsItrpNksp7sM3LM7hcMpvoJLCi8sr+Lllv2wBU=; b=PJuTbZbNazvEmeYEf
	UGPlKTK5WsFdNysMJeGOO7QlTGrEb+FDy1aQKYbsY/rZK6rIml2TO1oGqCmlJV22
	omhkJlNWlwt+GY8oO4YTpvEQM426VSpzaiwQ4ofAeVvA7xtiJfReDH/PQZRLOvoK
	NTm7Bvt34j6LFLB/UsJ5hWNsF8PhKA34WY3BMsbHtwG5ZROLcHd86mW6xzLSROzc
	KGCrGeari36JM+N8BSsPeOzzUjxtaW/s5G2uhlOCZ1oWGLMo8A8mXCmaGe4Ud6lL
	pM/WWfmugncvvPlL+Z5FThjh/k/l3qZDcNHcwGSS6nqti5BywwOdQTHvKpV7z3NO
	KRXIg==
X-ME-Sender: <xms:BfcxaQ7gsO7gde4l4MIaHB7QuKNVSkHFLYf5cjR1HMbWreUEeKPqGw>
    <xme:BfcxaelFLkliPo8d5pXhT8TSM4irncgOUo5LPVC8JObGqpn28dG8Us3AGrxa06eHc
    XJFt9_jbPm9i1yV5gU4zA-dZgL8rD_5d7GmRkh1uEPrcMh8IcLSXwbH>
X-ME-Received: <xmr:BfcxaTX9PLaOOsRZKmtvCptngj8NJnDw03uFKrty1nBxPbL3Kf8_HvfKMIKiddvty84evRVle_jaPxwj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeiiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfgvsggvtggtrgcu
    vehrrghnuceorhgvsggvtggtrgessghsughiohdrtghomheqnecuggftrfgrthhtvghrnh
    epgeffueeuledvgefgvddvgfetvdduhfefkedukeeikedtudekfeetteeifedvleefnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgvsggvtg
    gtrgessghsughiohdrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    hriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjohgvlhesjhhmshdrihgurdgruhdprhgtph
    htthhopegrnhgurhgvfiestghouggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghp
    thhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggu
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqrghsphgvvggusehlihhsthhsrdhoiihlrg
    gsshdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:BfcxafRgF2TZHU41D4KdWNt030T7DIFfZX66Cn66WlUyDbTKFPhCBQ>
    <xmx:BfcxaYDNdl-GOtwHUoY5PtXxlCqrFb-2HoN98HzWDog5jw3ZE2wnGg>
    <xmx:BfcxafvGtgQw1o0J5K013V8cAaQvZyz0Ma2HuBL6mXZSLnhjraZnnA>
    <xmx:Bfcxae_CZnFtAfafIM6lZIiQGvvyN5iGck0UzPFveHyqtWbDHeymMA>
    <xmx:BfcxaW_j0aazlwQIEDezxxLxo6C2razwGEW1vvrwxbnK56og5pUCGCIk>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Dec 2025 16:03:00 -0500 (EST)
From: Rebecca Cran <rebecca@bsdio.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Rebecca Cran <rebecca@bsdio.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/3] dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8 board
Date: Thu,  4 Dec 2025 14:02:34 -0700
Message-ID: <20251204210238.40742-2-rebecca@bsdio.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204210238.40742-1-rebecca@bsdio.com>
References: <20251204210238.40742-1-rebecca@bsdio.com>
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
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a..049e86107c50 100644
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


