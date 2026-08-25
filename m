Return-Path: <linux-aspeed+bounces-4857-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D3EC61DB9
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Aug 2026 00:15:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hV4th0SVRz2yb9;
	Wed, 26 Aug 2026 10:15:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=205.220.180.131 arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787644853;
	cv=pass; b=KKnziIEUkmmG3XWQAq7ccMj2LYPv6lmoNc8dsEvh0BFTm5R9DKvTJMR21HI7R6gnUyKqzC7VSncIKiRxk9TuYBem0rxd7KyapZIFm53Ihkg2brb7on6EvulKMd9ILBOsvqgNnxqhG3bgBXF6R3E/LuSUo0pciFb9Z738pJylLKCL5nG3klYBPRLqDrb7klBvp0+0FrHnbPp/5JrOpZUpcMBy257iT+xY2SiVtu/Ioi12wKcLvcywx33gB9uuweSvR1pFqcuWciZtB5aCGHxZSq3OUtsGMS4tY2Vn07qSHNP/qm1/h/SvHmODrwLczjvhSc7gxBgL+2wWIq1UNuUykg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787644853; c=relaxed/relaxed;
	bh=5i22KieYsA+kqY5NiRh4D02J0ZkjG6AI3NKqJFhFDss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SgPL42eA1LdjC8QyBk+3+CQHWC+gAikCRsuPMjozPRjXMdnzBEmWjAqtcGiRguw0pzhhXvjw4+tmcSflQUEJXaC/lyyOCugtglFkF8X+dvXmGeOvksc19MtuxrPIlczuSbljUL/g2oDjVIdq7HGMy0crO0mbZ5RVwG4pWvKQeWcVtVbJYv+0DRnj/vxhMAnU5FKbmElPC+ZpdSI9smYMCx6aLeXQqL3m83P32cy1AyijdccAr8SgS+PNGXPxTChIdUrp1Vd0CcAQ074XfY08j9v1y7QytNHYPp3zca7+J/uB8yNNBvVu+4C06u9IEUw7sGZA3hHGFhheUQ1iZ3+gOA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hW245yiu; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=arbXaHWi; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ulf.hansson@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hW245yiu;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=arbXaHWi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ulf.hansson@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTgFb6F2wz2xKh
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Aug 2026 18:00:50 +1000 (AEST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P2R1Z3404219
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Aug 2026 08:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5i22KieYsA+kqY5NiRh4D02J0ZkjG6AI3NKqJFhFDss=; b=hW245yiuzPpw7Zc7
	TgI5VNmqUcEW+F7q3OTTfJAr9m+I8U+Mi99eCl1qdFtPN2dzojQ3waErOzZM/SV4
	raw/gVvUm3SlExnqFleFA4w3we4B3eHvab/tWFLtTjSZXJfySDZ1DKqwOkHzrh9y
	+zGcn1Vz17mWFL/hvjpDHkwGf9jZMNi6GCRKAaTJ6aUKu4tlA37r3CBEXy+uI1BU
	nO9dfrLc6QhISS+yH/aHgJt0l/HNqwUSn0YC5a4QhIYZwS6zr9RomQjt9CEwUj1f
	SE7xuEoZrCDNPmc33MonGrwEmaAcBQyGQD4H94PSwHSRoxoysR8Tr3DQYjQOiUNi
	/Hr+0A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8y5jhm0h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Aug 2026 08:00:46 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so8813399a91.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Aug 2026 01:00:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787644845; cv=none;
        d=google.com; s=arc-20260327;
        b=mMCjudskHcn09Nbx3cWmDU2kJopK6yYH7M53zTUHIkAAXKdBObQFGu06VdQm2sjTCQ
         Ng4tlAnjaKCW2dxXxj4uFKJ9vNO4TxTidxPOnxjX/yyiAEfGV7QQ1XzgNGI+GgiGze0n
         VvYS0gur0TzwcRRR6Vm+hQ/9dC6r9+2W6Qvsj4XMJdYTvxmBwBUw3zcQqhZtJzD1HNcv
         Qce2jrPp9+Ctk903u0wkBdAx/MnWF906giivsXDrcKYLA6nTQfxp1HAY3IYaP88vZlnt
         X1BIt2mn8QBSwUofYlWjMB6FgwpYPSDYs5n3nrANrU1mUy8XUDm3XCB5j1HiuuHdQm3A
         rebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5i22KieYsA+kqY5NiRh4D02J0ZkjG6AI3NKqJFhFDss=;
        fh=iJggxB9KaHcLT4dTHPEE9UDgdHZCao6k0K7+C37pcyo=;
        b=guTXT3R9QSQ3SSSmUaFZW+9XXbm5E4V7CQDzlnyPs5gJ6sC53H7/sDEZtdbwkVvK9Y
         Fnvw+/5RVe+hew75vNIv+ApX2B1HgfaR5bdhPs86KK0VzpBqYrz+bPHFGSO/VWETgrl6
         GpNmyDuKd3iS8oQoqJUNrSdl+TvatWXgG+vC41Luw3LZVHGODm9mCVhjO82ggYEGp5+X
         4dpa8f6vq5GUKn3Knk3lKrDhnbj42cw/n/D1eyEd1S1gF0nofSgvB/7QtOxuYwQRHqP7
         ms97N+TNDQIRLpOidKQHKg8wG52/LPiZgOHAj2ufV8XLh3yVcblTEeZay+83WIjN5WzO
         UCMw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787644845; x=1788249645; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5i22KieYsA+kqY5NiRh4D02J0ZkjG6AI3NKqJFhFDss=;
        b=arbXaHWiYtzlPAvBzvdJsJdivfhaV405aBnU4NBOI6uEs9850kP8BGTFsvK/OFw43Y
         OG4Pt7vzVem03ylFxTOJyh/PmQORzWpALeQbTg+EVevgPOoxUEQp6isV0RaLckIZHEmd
         3tuZ0EDED7LLPs+VZi+RGhh1JRSuQDniK/475ZmcuRd9huqOGtD9wcbWU6BSryNmauYO
         6H0XtNB0PWH0rPFlipXBmVt41oECTtwl1vW6Xv6kAquW58CHQwDWwrJhStkuiA+VULKX
         gzP4l//l5b/9+tULPDXc0suZoSk1tyKG1nGNTTYbYN8pvkMBN/vbOhEq6thzpB+OlsQT
         yi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787644845; x=1788249645;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5i22KieYsA+kqY5NiRh4D02J0ZkjG6AI3NKqJFhFDss=;
        b=Wcsuax08rOBg/heGLWj/RDlp5vE/D2R39BArlAFPyDzBtJhYsfHlrq8YL1RC4/GxKQ
         GxaBRH7RM0KEVHKzMQgIla7wslplXmmXmdfWiUK98oeVemOuO4K/rbNcpeQLqg1Wy7Hw
         k3rsOI/TrgZ3YUPeT/CsFWr4A2f4G7b3TUMJ4S+T9QhMwB6fGjFFDB7m5TG6UWglBgN/
         94VBc0nqm6JgOaepdDRLrHFISTeXOsnvpzopJKBGAVuwHNEY2/andDUCMBIMa76NfNr4
         H1uijvshn+jWTAvs+mQ5Vmkxtp7Syez8lIYfUeiqFRS3nXvGj59r3sOAEDeceSH+w8p6
         CHpA==
X-Forwarded-Encrypted: i=1; AHgh+Roj5VfpaYm8vkwsB1SQ/XFhFMlcdoUUm01YGdA0lniBnmM4QXMygCyU32ZYSTIKmq2H7E/J9p+7ONU7lCM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l4rNa5n9CtbqBulkZzJlKhZve/9SW99+FirqJ1dFmOL1OGKOgh
	F+5c4+YVKMXLVmEOo8aRYlELHh1XXZ5yijwuHOoxMEYKsXIEkQfJ7nsA9uJrQVTV3fQLpLaPOIb
	QntWAK65rc0vppPikDCHLyEF/HMRZ3gnimTO+zz+uARGeHeaucIaT5+NX3XEeF14AKIugYWDzT0
	ehWexqLOJuJpY6plvO+k2DyPZeVBYoz1RDMAtQ3YzmkT8=
X-Gm-Gg: AR+sD11u/CqBo0x5Ps+Q6NUspo0Dc2r7tN0OBjAZ5V32osTiHmr9cU4LMzu0zoHrPQR
	gqy9t3UiHf4VppNvuRmW24/hRjp5tt0LVxnBeh9Zv/e0RVJDIIz+jVHYJKX7uJ0NfrTaUXIamdv
	XF6oOGo7Rp935flwXgFHW13AKl7bXbTzBSUZLo0LoAUjZe6u39eYymdAUsow==
X-Received: by 2002:a17:90b:1d83:b0:380:9f17:6df3 with SMTP id 98e67ed59e1d1-395c3367376mr54366279a91.4.1787644844842;
        Tue, 25 Aug 2026 01:00:44 -0700 (PDT)
X-Received: by 2002:a17:90b:1d83:b0:380:9f17:6df3 with SMTP id
 98e67ed59e1d1-395c3367376mr54366138a91.4.1787644844301; Tue, 25 Aug 2026
 01:00:44 -0700 (PDT)
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
References: <cover.1787239813.git.geert+renesas@glider.be> <bd84df92640a05a1a73a8bc775b2d50568a9d0ec.1787239813.git.geert+renesas@glider.be>
In-Reply-To: <bd84df92640a05a1a73a8bc775b2d50568a9d0ec.1787239813.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 10:00:32 +0200
X-Gm-Features: AcwNN1WaGLEXokEDN-w-P7YAI63J28S_AjYowYxFfZoRRRkDa1AUJBYrsKRUG74
Message-ID: <CAPx+jO9LSfy6-3Gb1+0RvHeVeU9dAN+-1jcGaCESpTZXEAE_YQ@mail.gmail.com>
Subject: Re: [PATCH 39/45] clk: ux500: Make sure clk_init_data is fully initialized
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Linus Walleij <linusw@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        David Lechner <david@lechnology.com>, Abel Vesa <abelvesa@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Santosh Shilimkar <ssantosh@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>, Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Peter Griffin <peter.griffin@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        =?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, linux-clk@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        arm-scmi@vger.kernel.org, imx@lists.linux.dev,
        linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
        soc@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=O5QJeh9W c=1 sm=1 tr=0 ts=6a8d4bae cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=xsHTnWN7LAWtonkW0D4A:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA2NyBTYWx0ZWRfX9LlS/PXFJvWR
 hMDEcDBVJ1vDIgr/70ElbVePnVzrarljRlU4tDmG/AdBwhfoIvgPm0LCQchD9ISXxpA8+3LghY2
 vVm7wQjvu8fHdv6m2oFdUxDFgfkH5a1j5cwS7GKLei2SSBagu2CH9OgeHT1NcKFIwYiCCx5hrZH
 yS842cp0VFUqSnoxIY/n3y3li6OIkc6YlcZ1JEN1YozXoGnCFZE7Bt9xhJYk/yNrsege2eN77IY
 UjChR2y2nq/1GCAtN2tnc3F2RSDxZqUNSKCXj5saQugmWFZywAB6mOYZ2PnaXlZYzDCFXpemCQL
 gCXWaxInU2WQW815azrwzEYR2nrJwUg4Pj4K3p158eKzx5xS7vVzxZU+Fz4BhpgEKuGP7dsy+2X
 Tk9k7niX2D0UPnNzDqj1kVB1PLh289JZvPybRB3+1kLdIr3b4TZZYlswxkDSZnm/WTcr1ErGD/z
 QdzNI2svPx9gEgAWzUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA2NyBTYWx0ZWRfXyde7Mcie+hC+
 tyxzIWnhopVh71eghdvE2yTwRCSMM7jxYKtFPwFxCqu1vuMe0GI5Csp6YvTkLkwgHEzGG52ksao
 +Np4mIRtumxIRmhORwfBkOWTrBcZclE=
X-Proofpoint-GUID: 1SZ36K82HPgI-SxkSIH6EJEMlzLC3mqT
X-Proofpoint-ORIG-GUID: 1SZ36K82HPgI-SxkSIH6EJEMlzLC3mqT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250067

On Fri, Aug 21, 2026 at 11:04=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
>
> Make sure all members are fully initialized, to avoid such bugs, and to
> prevent future breakage when converting drivers to a different method
> for specifying the parents.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
> Compile-tested only.
> ---
>  drivers/clk/ux500/clk-prcc.c    | 2 +-
>  drivers/clk/ux500/clk-prcmu.c   | 4 ++--
>  drivers/clk/ux500/clk-sysctrl.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/ux500/clk-prcc.c b/drivers/clk/ux500/clk-prcc.c
> index dce235df2576dfb2..dde72d2fd0ac67ae 100644
> --- a/drivers/clk/ux500/clk-prcc.c
> +++ b/drivers/clk/ux500/clk-prcc.c
> @@ -97,8 +97,8 @@ static struct clk *clk_reg_prcc(const char *name,
>                                 unsigned long flags,
>                                 const struct clk_ops *clk_prcc_ops)
>  {
> +       struct clk_init_data clk_prcc_init =3D {};
>         struct clk_prcc *clk;
> -       struct clk_init_data clk_prcc_init;
>         struct clk *clk_reg;
>
>         if (!name) {
> diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcmu.=
c
> index ac96c46bd1bbf76b..d89f3b634f8bbd26 100644
> --- a/drivers/clk/ux500/clk-prcmu.c
> +++ b/drivers/clk/ux500/clk-prcmu.c
> @@ -200,8 +200,8 @@ static struct clk_hw *clk_reg_prcmu(const char *name,
>                                     unsigned long flags,
>                                     const struct clk_ops *clk_prcmu_ops)
>  {
> +       struct clk_init_data clk_prcmu_init =3D {};
>         struct clk_prcmu *clk;
> -       struct clk_init_data clk_prcmu_init;
>         int ret;
>
>         if (!name) {
> @@ -357,8 +357,8 @@ struct clk_hw *clk_reg_prcmu_clkout(const char *name,
>                                     u8 source, u8 divider)
>
>  {
> +       struct clk_init_data clk_prcmu_clkout_init =3D {};
>         struct clk_prcmu_clkout *clk;
> -       struct clk_init_data clk_prcmu_clkout_init;
>         u8 clkout_id;
>         int ret;
>
> diff --git a/drivers/clk/ux500/clk-sysctrl.c b/drivers/clk/ux500/clk-sysc=
trl.c
> index ba3258c88d28e101..2127a949e56ccf27 100644
> --- a/drivers/clk/ux500/clk-sysctrl.c
> +++ b/drivers/clk/ux500/clk-sysctrl.c
> @@ -127,8 +127,8 @@ static struct clk *clk_reg_sysctrl(struct device *dev=
,
>                                 unsigned long flags,
>                                 const struct clk_ops *clk_sysctrl_ops)
>  {
> +       struct clk_init_data clk_sysctrl_init =3D {};
>         struct clk_sysctrl *clk;
> -       struct clk_init_data clk_sysctrl_init;
>         struct clk *clk_reg;
>         int i;
>
> --
> 2.43.0
>

