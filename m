Return-Path: <linux-aspeed+bounces-4364-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF752C43458
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 05:39:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtGXB3lbwz2ygg;
	Sun, 05 Jul 2026 15:39:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783107810;
	cv=none; b=kHsEIn6OlcFcJYW70q3xy3uM9vsYfhI+0G+t6IL3f/7hoZP+SWAxJL/Y6Fus2kf80bUc6OdTORnv/JDJuEhb5kVcY4moliZHPgNIvuhTdSNjDMOjWS2+mCBpDx9l0qoVv+QsevoC5wNPMj8/yjuG4tmIs8WUalgdJD/K5TgOP/H97pNiXVvnWOuN6PnXxuxDwc+qatuNcOhR++d0ZVfJ87rDuw6qeNFVfZBUZXYGDt22TxnRWnvCOLrrKGS37q4Q+mP4cMA9F/26YGDOBEMuCME4XjFRhmm89dhVguM0cTqJ1HWRkprtMYTjpEGecy+b4QK6qYwk8PM1WduyUmzenw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783107810; c=relaxed/relaxed;
	bh=bn4n8Ensq4b2jWU5voHmUQF7/CVhT1UW+T0M+N3rGrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqkSqJOw0S1wZRCQ3p501GFnk/ir/Yei/C5CASCw0TCrV/v3qWyYiuO7dQbryLsF+2PJL51gCKrgHjqKwUQl1mbU/oFgCKdOMYkLE0nbS5++a1DlKSM0Vhxyvohdj+VYin3N15jjYjNHAihfxw6SsVb7m9xD0FiqSNmH/d/lOFRw6yTKwLOR+oVddkKPLK7KW5b8fbROdl/gmS0O4JJC2w2efJ5EgQwlORid4+7COjXIIt6+U3rbtkrzGmsIpTq/bsnZz5ZKGpv/OeTSrM0gXPC+s1sUTc3y3dv+pHmerHAF8MN9gVtuyB+pFb+6FKStJFm4UGxM/bV7JMj0qkg0uA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nOeTG4ty; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kB3BUrdl; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nOeTG4ty;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kB3BUrdl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsPLn3Hk4z2xLq
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 05:43:29 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663Hicbo685038
	for <linux-aspeed@lists.ozlabs.org>; Fri, 3 Jul 2026 19:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bn4n8Ensq4b
	2jWU5voHmUQF7/CVhT1UW+T0M+N3rGrg=; b=nOeTG4ty30vKw+ttbYanSVJ6ILE
	BTAP2O4+nJPij6iXWRyXJ6gBds/5MB5tBMGqFWh+/u8gKduK/0McbMFjobNCnuzN
	1y+6/ZZnKyZ62+pPM/DEC4Iylg8Krq0wAPqD6KdtuGk+Zdk4DKUeyMhiXbzJYdVL
	bIj/QJM7hN5BtusgbHD8m9xNThogT6wHKhQIkdOp/hbQypKE27fZgHchGeO+1BTT
	VPUpeh/bBZI59ScXYRgw65wzTgoMMnoJmFsZzRgRsYFyWaGGYCwKpfq4lPUztwV7
	wVHDf06/SCOxR42J2Z9vbHr4UhAdTAjtbJeXNkQiLE7+wIkknP7olxo/NEw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5bs3n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 19:43:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-380a638fb5bso951696a91.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107807; x=1783712607; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bn4n8Ensq4b2jWU5voHmUQF7/CVhT1UW+T0M+N3rGrg=;
        b=kB3BUrdlph1lRpii2l5xwcZ6jgJga/QQ+yq4hze3FcjO4oNlUCPP+AOqi6UHHjK0+3
         wl7ji4IM4nvbWAlU+Wjmd6cGiZ5kjOEQM/ccemytrUGUXblBuQYlM4DKZQDeMzhtbb5F
         1qhaBhPfvwj/zIv7+AZv/SQj2olUL3J55NXzZtFiJ+QMVihSodxxZwStcWaClmaowv5+
         zgxOYIz7N2uYwdK5qQeYxyZTooCGoq0Zt2Zmrh+ye8j9MlSlyETi4qA0ZBFN0RTLucmF
         NgkKUOh00smwRxLFKch0h+Ca1zGnnuhY9RyiqUXQxkMFKBOw8F9ZiRfK+HvKf0TR1pft
         s8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107807; x=1783712607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bn4n8Ensq4b2jWU5voHmUQF7/CVhT1UW+T0M+N3rGrg=;
        b=BqR4/MFjhZbRV9OUCyqBjeIJCYz755O0bagJPy3ZsvFgQpIKSxtFzpet68L7hETz8D
         Oigx3UAMr1WyO1yytbNh9uAEWkEKPKWQ9r+F9CaGDByyHDur5LGd5UjhzNOgQ3Ema6Ll
         Tm5R25XN6jYmxrx/pVZ++6H5bYtUE4rJMO4kFvg9kMnBNtPqi4KmJTuS/Y8F7l/oJ2eQ
         zF1QmSdlGy+x4FmV5RmjpZXRuHpVw88lsE/A6PExR7Ml/3Svs0+F50lcunF/gV6ocmoy
         lz5RIzVfFMSbUHyh/C91OQRnKvinkAOl4i6I8jHqzLynfKoa+3bT5RUN14D5PZ83Tje8
         C5lw==
X-Forwarded-Encrypted: i=1; AHgh+Rq163UXbUgaSvAYARYYCYrDM3SES/aUN1xLf+YXBC5RdNOReQwgamMlNCG0hPvYTLnmRfAhvdrWPyR7N/g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwaA+PgKjwCyvdYvDDWU3syqbZz1HcC3dUVYIaAe+TWV7IcT5J7
	vgTQpITe4Y6RAeOR/EaJsW178uTG3QKPG59ekqTyDBo+/zLGYE61wQyr2TZC5jUi20qiaBpbaxA
	JEazqCKFeD+tyxYY92XV0ws6slx3LOaQvGZzDfMgbcj+d5FMF3TMi/ku4/Hf0swCv11aa
X-Gm-Gg: AfdE7cnWxi2BIVg//AjtcwuBtZ2W28p2ITzqEaFE3Ku6+5YxIoQzxZJGZoaVZho5anl
	g5ZJGNTpWOReFx3wSz/HaTAVGoZkrrbX/ikbmDw9jhj3eCf2A1TqY/sPJtGmqpK9x6E2QfCNBgJ
	6VFaQDDDC5FxrciBQwgPFwFmOsvVUl9wlQxB4BOnR2v1LXXnDyDJ+h849Uvs56tRJ12RX+8U7i2
	QoV7DyV+07H8DWhnIrkwkLkQmc8PT2VNcIn6R6O0Q7pKGr1AkpnoTFq97BGA4cOgOL+apfcNhdn
	zFe/vZjiC4ELYQhABF5vjC86TNP144lq0AOGrT84Zy6nJtrgT4i38uMbHpFLmhU7+k2wvKf3i2f
	bBmnDctPmx8zys2lJjD2XxDj1+ez81+KMCVCDXw==
X-Received: by 2002:a17:90b:48c6:b0:37e:2005:6507 with SMTP id 98e67ed59e1d1-38280e98cfamr773034a91.15.1783107806466;
        Fri, 03 Jul 2026 12:43:26 -0700 (PDT)
X-Received: by 2002:a17:90b:48c6:b0:37e:2005:6507 with SMTP id 98e67ed59e1d1-38280e98cfamr772970a91.15.1783107805852;
        Fri, 03 Jul 2026 12:43:25 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:43:25 -0700 (PDT)
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
Subject: [PATCH 10/42] drm: pl111: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:23 +0530
Message-ID: <20260703193855.110619-11-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX+xuHJFw+A6ey
 wQoSLxOBAWDLh61QMJbxbQhh5pLrtv2KPmYW4hJmBxXuAraZ1ojtCdzq52AESmkSNekF7yppmir
 f2ZQynwfbhgNIyx9jeqNWR2Ud3nhmDc=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a4810df cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=ih0ztwYHz3j8HjU85xEA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: hqSEmmBK9kX5r7VuzUprl3Dm6XbrpNp7
X-Proofpoint-GUID: hqSEmmBK9kX5r7VuzUprl3Dm6XbrpNp7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfXyFv3epoLc+p2
 m+TZ8P0lDmVVvBkELhYsIIFD/+ykQnJubDxlK+wtVvnOtlTdsTrSMWPrtCD2d9KJHUhs77vfdM8
 Z1B62sNRVsgYoNEGEAp3mt5xUMVW1+vm7N94cUhVEWAQOGTtRMVBVtnN/TWZVr74QuIwiwnfmDr
 fwmdP6Dzz5BQGADiiCH2JXgXTdKo901+wPQu210N8dLLCwJcn/xPjPFDlykB0SANKit1up0r++q
 g5/EgOam2mOqzVoB1fHnW83Auo1N/BhB0T/9e+GDu3O4aGSotz8f6bhggA1yaqpK46NCBysPIQX
 MuUG6VD/b0INyyLzDY7sUIpueB1M2GLpO6ExXjnn8opj4QV99nboPYidXGLuRMpHuhwPKSWK9PV
 F5+ylJ64/fum88DYwRbQYfFCZPFRptG7tl9ZQhAwh+a1eOYNrl1h1VqdWtQrd4x0OeXrh4gbgki
 lE/UWztGc8piooah/zw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030199

Switch to devm_of_reserved_mem_device_init() so the reserved memory
region is released automatically on probe failure or device removal.
Remove the explicit of_reserved_mem_device_release() calls in the
dev_put error path and pl111_amba_remove().

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/pl111/pl111_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index ac7b1d12a0f5..25ce37a4e8bf 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -254,7 +254,7 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	drm->dev_private = priv;
 	priv->variant = variant;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (!ret) {
 		drm_info(drm, "using device-specific reserved memory\n");
 		priv->use_device_memory = true;
@@ -313,7 +313,6 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 
 dev_put:
 	drm_dev_put(drm);
-	of_reserved_mem_device_release(dev);
 
 	return ret;
 }
@@ -329,7 +328,6 @@ static void pl111_amba_remove(struct amba_device *amba_dev)
 	if (priv->panel)
 		drm_panel_bridge_remove(priv->bridge);
 	drm_dev_put(drm);
-	of_reserved_mem_device_release(dev);
 }
 
 static void pl111_amba_shutdown(struct amba_device *amba_dev)
-- 
2.53.0


