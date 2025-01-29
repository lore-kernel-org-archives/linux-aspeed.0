Return-Path: <linux-aspeed+bounces-583-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4684AC02193
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jan 2025 22:56:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YjyFG6gKBz30TJ;
	Thu, 30 Jan 2025 09:56:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.132.182.106
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738143673;
	cv=none; b=N2HMqjvWxLslkoEhyCM6kyoRjjhyTrd/B90uSA3qVpaecu80527yXultl4KMBDcqJ7KNtD4+3kY/styRn4k0hsGUJy6jTwLwSZJXttcbjSnlg3dK7UQYYJCiZprKr1dfsYN+W2s37NG+e9xSts6E2j0bdQYaYZ3kmRTnQvnYEevcmx0w6fbay/JaAAtDreXdLFUocrCqaELLCTMf+gPGOh2TgZZk3bZvMcfr6BgIhd4cIWZqCqlV6+PbDNyZE/FckmPlhefT9PeNGu5Vr+QWaUWzAY2OjrHi+3q8o+UeFT879+P4nXyJxpHJiwAvc6ytNSK8tyJb+G1cmvIiB5JNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738143673; c=relaxed/relaxed;
	bh=K4w3bUSNuMoGr2Kig4zaKtlQZ0vMGzt2g+mK00D8dss=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OVbRdprgBpikitBOZlxxVw5m4n4M/+kFgeXyT/3nbEKK9ccxiWMS1rT5WU5gT2tUTHhbQfQO7by6hUDlaSEVTF5Dhhibq3XIzuISazJmln+agivs+lVxkqU3RamhVnTWpT5GbWgmfhGqyu1Ri7aZ4Jkj6KQ/w27xv/+Rp2qovu8w0I5hmECxWp1PiEPl66sKNq6YObFRjOk/z5+H1VR5LYOPzttEx0fIO89lX4mA9BLkjj0ADdaJoOUrTjUB6ND93RD2yI+sMmJBRyH9X/PusYWAUTOE7rn4fjgui/WugIom54dw9BNa7Ck+pGryTSXgwaacUElvj2KHxSsBKI3lWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector1 header.b=tMvjzHGT; dkim-atps=neutral; spf=pass (client-ip=185.132.182.106; helo=mx07-00178001.pphosted.com; envelope-from=prvs=412475eb54=raphael.gallais-pou@foss.st.com; receiver=lists.ozlabs.org) smtp.mailfrom=foss.st.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector1 header.b=tMvjzHGT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=foss.st.com (client-ip=185.132.182.106; helo=mx07-00178001.pphosted.com; envelope-from=prvs=412475eb54=raphael.gallais-pou@foss.st.com; receiver=lists.ozlabs.org)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yjcbp39TYz30Q3
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jan 2025 20:41:09 +1100 (AEDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T70PFW009524;
	Wed, 29 Jan 2025 09:53:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	K4w3bUSNuMoGr2Kig4zaKtlQZ0vMGzt2g+mK00D8dss=; b=tMvjzHGTjT58kuPG
	X0FNR92wGAnCeJMLNfeQFLG0aDfxwj/uiGbml2Ii/aOgWYwPzqCvNSKYu4GqOQB1
	q1zub79jG4YxfVTmRzRjhsB+0NFWyp48k9O6ZEYsIMKxNY2J/mhhgIeJ6OrLvqo3
	XiabZikb1wAXVUlZonEdRkJ7cBZsOTPLe9GSPXYeYVWaleVh0N8Kj77R2pgesZ7X
	Ga/mTCjDbvKDu4U8caR4kWuElNBbKqk0rjZNvInU3YgFQoW7db0zqsD8Ws6CJOHt
	kG5vTlESpG9lepXzb7FzZ9WgFpxyOQLUtHyCGovn59v9A9BRx26SxRnrp2kjgeKl
	zKhhZA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44eyew3g58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 09:53:58 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 249F740058;
	Wed, 29 Jan 2025 09:50:17 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8E0912ACA61;
	Wed, 29 Jan 2025 09:47:36 +0100 (CET)
Received: from [10.129.178.211] (10.129.178.211) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 29 Jan
 2025 09:47:34 +0100
Message-ID: <5131c24e-fb8d-45f1-9b1b-e65b2613e85f@foss.st.com>
Date: Wed, 29 Jan 2025 09:47:10 +0100
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] drm/stm: move to devm_platform_ioremap_resource()
 usage
To: Anusha Srivatsa <asrivats@redhat.com>, Joel Stanley <joel@jms.id.au>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Andrew Jeffery
	<andrew@codeconstruct.com.au>,
        Stefan Agner <stefan@agner.ch>, Alison Wang
	<alison.wang@nxp.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Tian Tao
	<tiantao6@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Sumit
 Semwal <sumit.semwal@linaro.org>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        John
 Stultz <jstultz@google.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp
 Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Neil
 Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>,
        Marek Vasut <marex@denx.de>, Shawn Guo
	<shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix
 Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?=
	<heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>, Orson Zhai
	<orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan
 Zhang <zhang.lyra@gmail.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Raphael Gallais-Pou <rgallaispou@gmail.com>,
        Yannick Fertre
	<yannick.fertre@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jonathan Hunter
	<jonathanh@nvidia.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Dave
 Stevenson <dave.stevenson@raspberrypi.com>,
        =?UTF-8?Q?Ma=C3=ADra_Canal?=
	<mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance
	<kernel-list@raspberrypi.com>,
        Jonathan Corbet <corbet@lwn.net>
CC: <linux-aspeed@lists.ozlabs.org>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <imx@lists.linux.dev>,
        <linux-rockchip@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-tegra@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20250128-cocci-memory-api-v1-0-0d1609a29587@redhat.com>
 <20250128-cocci-memory-api-v1-10-0d1609a29587@redhat.com>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20250128-cocci-memory-api-v1-10-0d1609a29587@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.129.178.211]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01


On 1/28/25 23:29, Anusha Srivatsa wrote:
> Replace platform_get_resource + devm_ioremap_resource
> with just devm_platform_ioremap_resource()
>
> Used Coccinelle to do this change. SmPl patch:
> @rule_1@
> identifier res;
> expression ioremap_res;
> identifier pdev;
> @@
> -struct resource *res;
> ...
> -res = platform_get_resource(pdev,...);
> -ioremap_res = devm_ioremap_resource(...);
> +ioremap_res = devm_platform_ioremap_resource(pdev,0);
>
> Cc: Yannick Fertre <yannick.fertre@foss.st.com>
> Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> Cc: Philippe Cornu <philippe.cornu@foss.st.com>
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>


Hi Anusha,


Thanks for your work !
Acked-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>


Regards,
Raphaël



