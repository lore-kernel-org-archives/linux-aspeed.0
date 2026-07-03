Return-Path: <linux-aspeed+bounces-4377-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E2AC43602
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 05:46:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtGgn2FTHz2ypm;
	Sun, 05 Jul 2026 15:46:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783107980;
	cv=none; b=h7xKMIuPJptoUnPFipwfj/ADypxAg1eGtQ3gU5/q/Bgra0VqY1Ejm9XATxLJ2j2/Yl6xwM3GWR9hek4SMHl9s+Us9tqOceoU/rork1OZqfC+eDb1QMj21hy9vZQt52+kc/DohdPe5c+mvWsi4agiAjXydSMDRzO3MW/B+FyancfKRcy5P2tOl55gNIsrsChP1KPvMFRZB1AeFYudygYwXzkCAYk5dtIttW9OavT+YCUzLmp876haqYlZVyFkW1cLNXBF2l4M1X07riOT36Fo7MAZ0vL7cVOCUFefBvyBk743Jaq+1y5qOBrxitIomLT8cJmvG6DdmbKgtK0y98Hk5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783107980; c=relaxed/relaxed;
	bh=cv8Z70k8ciR2WfmKiPLW243jrDjjieLnK77w7rwJLZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gh8ZcK13y0vjTFBjes4oNiFFtHp6O6Dc38uZnYps1AOveTWpS56sS1Ex+gp6hKwlsnWoGyvXIUhPp1pgGfNrxLFBkhTcoFUO+zcA1lgk5FClWIPUheVji4k4Gw7qEc1LT0nwxHteqRvT0ml1gP06uULkFRW/cOyycQTaR18Mjq8hKtpNEeY/MdyZ+MZyqcGPx0KyaQqxrz26IYJv/KQ2VxZM9rYblkraLu69j5XLtGgaE/daDcByTdGcei+9KHTZkxCWV6xJaEMo6xzByN8MPRKOCesmirADr6ag1gHf8yt56XFurcRanU6uXdZMvERk/xde8gEsLuu/vmL1OURGMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sb1uIwnv; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RoDrvnWk; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sb1uIwnv;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RoDrvnWk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsPQ32pmmz2xLq
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 05:46:19 +1000 (AEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663Hj7jG547994
	for <linux-aspeed@lists.ozlabs.org>; Fri, 3 Jul 2026 19:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cv8Z70k8ciR
	2WfmKiPLW243jrDjjieLnK77w7rwJLZ0=; b=Sb1uIwnvYj2uETwfHvteOGjSG6K
	JXew0PFUKn64Jx+BTzBOG9vyluIa46v09u3diiZJGxx2REwMh5MVVEQCdko2m1m2
	X3WTpN60KDEWQ7NHz0ELskiwfWEnv1CVkF9EDUiQoaFGnl9iOqG+PwASCsZanogx
	3Pk4bq/g8TllNFlKP7Jc9oBfx17JufnApzflD4ZLqzWUrCXaUXLhncmsjwRdgVCL
	ZDSXeCpRVtlczU6Szn4CjO5K1A4lLTNZunSigmk3ttg1AiKNmcK08JevFSjUTgmc
	N84jDNimEarl0/409TEhjBc7JaEnERPmAY8QmUuTT7AsNwk9w6mSewmHG6w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f67j02vwe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 19:46:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-381250979d5so916348a91.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107977; x=1783712777; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv8Z70k8ciR2WfmKiPLW243jrDjjieLnK77w7rwJLZ0=;
        b=RoDrvnWkoY0HqTLIXq4JfHX5axt2qvL+vUABAs3yFJSf1vrCuUrmUkMe58ddl2hgqM
         SRpyrIAF0ugjdNh68IHuGmCiTCy7cnqrJoJok6KzdHreWTZ15ZGEKYbcztPgTeIIYKj4
         5mYbINCu8XRXpQsnSZ4wxuRaYy26wQe/fH3LO0QE3JF0pF+0WRk7/gPpAxQTynYojsgf
         SBPtI+aBxUo/4Tji7FyJHGyk4h1h+J6tuhyDUnOrAS1CTBK17K6zAm5n3qAFwLbH0dmj
         GtPxcO4J9f7QwTpJSV9zEaHy9H8HnD/crGfXb95oMZqVcbF4HJE62ALv2R1r6qPG1m7u
         3dzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107977; x=1783712777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cv8Z70k8ciR2WfmKiPLW243jrDjjieLnK77w7rwJLZ0=;
        b=J67Tyq9r1ADIty0eLlmqIBIAaGcz7qTaUdI+X5Yc5czk2o+O2WgqnJ51dJW+uAFwoj
         Lchz/NRnpUAGaAs2oqoppYFBklmd5aXkRl4nX7GAOt3f7nSFTWdxrqfq8DSOTOnfefmp
         cSEsj/rS8lPSZcIlEljP7X/KPa3uaE44AyFr7K5gT/NbuxyggnQS586plpfQ8N97/KuO
         F8gkYoJ3E/W8m169OkMfA9K73A9udEMNLL4qWZyC3ltznRHrjUaCG8SQ2zA1rhsMPwUe
         ejOXrFfIYtD3nDiqsOnaANgcSto4IrEigUvODjz4T6Hk7/WOEaTfIDwkiPG8kvSivfJT
         UpGw==
X-Forwarded-Encrypted: i=1; AHgh+RoGayWI8tS9xfphDDHJPVo4mrsOt60ZprCVr3Euk+KjIc7jh6mLFdlP24jdYoENAl7suoaehBGeYfDs7wY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwvzEtvk2InB7DqHg1jNjP+7hGQwi0GM1TC0j8DIRjdOsCiYh4p
	4h7zkFNgf/Gd/Tlzz/ylxm0yFUcdSx8gT/g22ZV6BWrzj8p8W/zuKR6mCOpmULVuJCv4Efu56uQ
	h15pwlwjpPycmaAypALr/WN3qtwI8j9sMGRTFZf6qPQvw/KwuCYaUY1ErO1HavUplSUSt
X-Gm-Gg: AfdE7cmDfPn7iQ1Kia2RNOom+548TfJiWevw0w7/4smc3zDlXWx/dNDipbiSyfMyqiX
	HMbNW9hqaaq6/CniIdHVQWuM4/VGUUspRU64yWLs+sNl3acfvxya2qm/HahNw3cem/6UANKNR2T
	PQ3XkWlGpE8ULCc5BTvPF2Sw+NK+NxQsPvzlXUMAaVygTIt9qKrJS3USBf7sxNMi6EuSd9mVU1B
	rWXvetD2ETUS5IzxxY7eVogJLJkQ2zYKAsU6jFVyJ2iyik78R6/nG3DzJU10OhXeWUuQGSG1+Mm
	UUs1PIBUpUr40baTq/vumyotD4ZtR8Z0iMnJiAjWyAY3be2ROZv+lUOTWkDLcvGqzyyXewGoO/j
	W6ZQrNAswVgo29CtuYatNfFJL7ISoEqhzTHD86A==
X-Received: by 2002:a17:90b:1c81:b0:37f:9cdf:f03a with SMTP id 98e67ed59e1d1-3829f4e8836mr700686a91.29.1783107976446;
        Fri, 03 Jul 2026 12:46:16 -0700 (PDT)
X-Received: by 2002:a17:90b:1c81:b0:37f:9cdf:f03a with SMTP id 98e67ed59e1d1-3829f4e8836mr700565a91.29.1783107975869;
        Fri, 03 Jul 2026 12:46:15 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:46:15 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Paul Cercueil <paul@crapouillou.net>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Paul Kocialkowski <paulk@sys-base.io>,
        Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Michal Simek <michal.simek@amd.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ge Gordon <gordon.ge@bst.ai>, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Peter Chen <peter.chen@cixtech.com>,
        Fugang Duan <fugang.duan@cixtech.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        kernel@collabora.com, linux-tegra@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        imx@lists.linux.dev, sound-open-firmware@alsa-project.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 17/42] drm: ingenic: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:30 +0530
Message-ID: <20260703193855.110619-18-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-GUID: xngZsXtBiz_Jbhr7AtFPJ56kMNgXMtfK
X-Proofpoint-ORIG-GUID: xngZsXtBiz_Jbhr7AtFPJ56kMNgXMtfK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX8h5RZUvaEIbf
 UAXU2pYDpS0ZNecXo3N4SZXrlfWv9pKW1f7a3cAZ/JdkGEjkrvBaAkZDkZ2UK9Rl/tb+yf+XVjW
 Scdnm7qSfb2MffW6WCRfoK6cY7fflXQ=
X-Authority-Analysis: v=2.4 cv=Yuc/gYYX c=1 sm=1 tr=0 ts=6a481189 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=iWCwWg-Lr60CcT_aNAIA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX2o/o67VZpuS5
 WRH5pCG6MIPRGHa7SENfpRfB4QNkU5Z2B4zqbJLW1PMkxHAuXWp6L1Nyebw7EjjwHOT/yv668Mq
 Ea+8zm9OsOlYx5p4Qiz9ofL1k2HUiQGjoTr5zzCNW1HuJ3+wwGO5LnaYeCAC1hFNrARjeS7udTD
 4gCgj0xajrX+fL+VitRiDG1TW4kTEm/odyV152FtXbQ+fh0iUwqxGgKh9V7BPjvETJ0u3o5RzmZ
 S4RdNi7TLRbjXdjGqszOSKbz+qxT6Sk0HXOmM48oa8p2pa1z8PnbMnTHDrggsmDw7ni0JJVa0Wy
 d4k2F0MRM/aQrMY9p+DD0BXLy1XbcrajCAh1gxRUtTDnkaL36xIy+EodHm5TpPbvhXzP0n8g5cQ
 yuQPVWy54XPfrl+O1ANs6WNVOcpW6cactWt9gcYZNtWvMgtIhAnm0CW2l+ZDzKVabJwp4hDSNjU
 YepnHsbHM0mS/kRnB0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030199

Replace the hand-rolled devm wrapper (ingenic_drm_release_rmem +
devm_add_action_or_reset) with the standard
devm_of_reserved_mem_device_init(), letting the device resource
manager handle cleanup automatically.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 7e569af22391..990c3b4625fa 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -1060,11 +1060,6 @@ static void ingenic_drm_unbind_all(void *d)
 	component_unbind_all(priv->dev, &priv->drm);
 }
 
-static void __maybe_unused ingenic_drm_release_rmem(void *d)
-{
-	of_reserved_mem_device_release(d);
-}
-
 static void ingenic_drm_configure_hwdesc(struct ingenic_drm *priv,
 					 unsigned int hwdesc,
 					 unsigned int next_hwdesc, u32 id)
@@ -1127,16 +1122,10 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 	}
 
 	if (IS_ENABLED(CONFIG_OF_RESERVED_MEM)) {
-		ret = of_reserved_mem_device_init(dev);
+		ret = devm_of_reserved_mem_device_init(dev);
 
 		if (ret && ret != -ENODEV)
 			dev_warn(dev, "Failed to get reserved memory: %d\n", ret);
-
-		if (!ret) {
-			ret = devm_add_action_or_reset(dev, ingenic_drm_release_rmem, dev);
-			if (ret)
-				return ret;
-		}
 	}
 
 	priv = devm_drm_dev_alloc(dev, &ingenic_drm_driver_data,
-- 
2.53.0


