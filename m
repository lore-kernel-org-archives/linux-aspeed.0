Return-Path: <linux-aspeed+bounces-4369-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69EEC44500
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 05:41:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtGZ34ZLcz2ypk;
	Sun, 05 Jul 2026 15:41:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783108344;
	cv=none; b=gZPeuCbUX8oXw4FsCOgqOmBPXY6am9YP5UQNYpScDfusDF8Uw380o4kcOTILDPAD+Q/3rWhKa5ZL8WmnQpTrgluw6Wl6i4liY4Epg5F5pFtHIoHt2e5D+xH9ERfBNFP2H7yJzRMstSUnajDMB1mzX+JfQqhDxviTskd/JMaPVkrq8vXJN6N+Lch1Rh0VL/6FEabQPq1k534C8Z/7P5+FfP+c/SvmP2YVPFOwFfzN2J+tuoiXtp/ALPes7vDPt5yin9BoV8NmyosfOdtui6BWYVmtFQ3HeX9VSXRc4ZjEaeofBqTc8jAwjTJXTc7/hS9nIK7h9HjVpptORJKet1viYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783108344; c=relaxed/relaxed;
	bh=DVazRrG0aSxY8WYlC8x0UHgHkIRBJsYN5YFcXqpwEZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewYK9mQSwcPcRp2+ZVl2mJW9IL62CL4T9K0jPQgC4t/13xrvOmdkUAjSxIPyKu+0hhwKD+yRtC5ProTWPmKB7e4IVa4Jovp3PDKwyUslmZdlRAtys1IAc09MNsC+dkOKWCUD6Jm/qvrYvjoa60i2A5y7wTwzNRQyXQjmewCFaSs5r+0uRehk8Och6mrcdhhM9ww/Z4YSNARKCN4C8e09MEXGEW8evQ0Mq76CUVBMsAh4t0SKScBTHd/IPUuCiEwlLeqHlOiAt3EtkZeGsLMEHChTDZRNDctHVu9xnernArIIGPkXlP28s6A/nj+V/x65dAbMHIzgHCcGsVLAeLD2aA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TXRWzJJ2; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U+S5NW/E; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TXRWzJJ2;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U+S5NW/E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsPY26xh9z2xwM
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 05:52:22 +1000 (AEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HiQpV631361
	for <linux-aspeed@lists.ozlabs.org>; Fri, 3 Jul 2026 19:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DVazRrG0aSx
	Y8WYlC8x0UHgHkIRBJsYN5YFcXqpwEZE=; b=TXRWzJJ2mDiAw8ndD7aCyMTUf3i
	qUwQeZ18wqKRvWYaRG7r+U4Zxk17QhXrKV+uyNMifJqDY+dgJJQUE1PxEVafitbL
	/sq5Mw3Xx8o/4twkp24WyE+09HMdwsGNbm1kb8tfUe4hThZERMz+wvsZtyy92Lwb
	nrBIctgsjjqOJkLu+zd2LD45dyuWrZ/mPnBa/MBW3qg8dEJJgHe+i4VpsMo3vRop
	HEkWuF2pAHHoEiQK1DLWavNEjRrtWZLcXJ1zYzjPtBxzPlLbgbJNPMNInXMxnGEF
	qThiaYPMZK+b3IqAmA49y6rMxQqQcVfei0p5lzYtDgpnoThnuaLpXxDP8BQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6b03a00h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 19:52:20 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3811279d51aso1630759a91.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 12:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783108339; x=1783713139; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVazRrG0aSxY8WYlC8x0UHgHkIRBJsYN5YFcXqpwEZE=;
        b=U+S5NW/EpIIcm+R3iW9jHllMzfvv96i/PfT49/1OnroiH756xFUa7cKZtVePJope6a
         V44hYQqB1+bb43Mdf9QE/N600DSWJNyFb8E9C5tbdxVOTDBvtSJCacmkRf2PSPlHbudk
         q6sQFLyOCbNyeQfFKiCWjDyqNcA2tyXveYpl1RPGuUg1S3kUfPq00Q1ZWTXKYVP2S5LU
         eA2M3AQoamvUHSLhNJXgdUG+Qc3wXugOV5597noZEXCMTBl0blnpt8ttbVKXvAA6IX6h
         dMwq91lZhAtXFNIJN0vOdPn0xdm0QoNUusSYlVgbCTWfLG/9GYuzZArQHrlRdaZJA+5e
         1vEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783108339; x=1783713139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DVazRrG0aSxY8WYlC8x0UHgHkIRBJsYN5YFcXqpwEZE=;
        b=oK/TYOR+3NtnWoJd1xO2uh/JrBoyORO8Yb1IaipsHuPq+b3BHl0X8c1vHaKlughVKV
         3R8A3v95P0drkdRnJnEkdrj0FVU+DKce30MBnAu4ptF/SFUvsxhIsjfOCzo4Ja3SSdIE
         w95dvI57GW01vhLlgCRRkWmdrFFIOR956OHz3soiC6sajvXUO+xETH9wRV2O7DHrlUof
         lZr7RGteknfiYs5W+yrx8wU81DmY6/K5PAUZlzIxYxAfagZOij9Y4x51eTjUASTA+iN5
         ZTeWyJ4U7gfRpI7tmPYDtMTeMv/g5DYFMSeLn2J2+HS4OgBJf1oTcNfQProV1yyyKou6
         2I3g==
X-Forwarded-Encrypted: i=1; AHgh+RrwHTA4azeREaFNFOFv0ojs1b/XB4ObW4VfV7vDbK0x6AzGHPQQCQ8bNWTSpZ3mCiJ96hkSNDd2g1T6FZM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxCoNcVZclrI2gx6yOOjSsX4JVNxqh6Cdk6EfroUefVom04Yyvi
	ulqMkD+3QbwhKscsSkI1JzKgGLuoe3kNV6SmtyZVJcirx+pu+jFTnXdvYObcaDY/AZ2lDJI8xIX
	y2BOl7A+bKF0qoiJAcJG+nIJR4uy4PMx6s6BOUZzeCjmyB9NYhf/FYuJ2eTfnsRzVr9EB
X-Gm-Gg: AfdE7cmLsl4nMNFvqcoHJSYWz+81OjJmxdVqywpTEWsnk8ieFuC/2cmwhIxrKPEgW34
	wuQr/XtY4vMA7hUTcqj8hObkxV/PlTC8/QtyItMvbXaL/m7xVZj38S9O9rXT2jmF+9xk3zdn+c5
	TPxrRDTLVb+OLoRhvGryqzsCNkK+HV5CcRZ1MD6KrmQDQGxLcudiUoc9Kj8f0fhTjNLja+CeFtk
	rryWAP0h9pDEgtEg2+O5KnZDpFu0sumscCL1ScdeFlnDGydqFo+1qZ8RJvtU76Hm3rTcwBjRME0
	tQOgrfK+ExWXEdvvcWWU06Uz3RtzK30ZulSDhcSbg0eaJ3RuLGdTdGIOQv6CMKwSvu2FFxU+WMp
	SOejQO3ATx1/UHmupEL9BY25pPZayLB4INt/Ghg==
X-Received: by 2002:a17:90b:2d07:b0:37e:1bc4:b6ae with SMTP id 98e67ed59e1d1-382808b20c0mr790789a91.8.1783108339151;
        Fri, 03 Jul 2026 12:52:19 -0700 (PDT)
X-Received: by 2002:a17:90b:2d07:b0:37e:1bc4:b6ae with SMTP id 98e67ed59e1d1-382808b20c0mr790679a91.8.1783108338648;
        Fri, 03 Jul 2026 12:52:18 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:52:18 -0700 (PDT)
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
Subject: [PATCH 32/42] drm: aspeed: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:45 +0530
Message-ID: <20260703193855.110619-33-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfXwT8K0Et+SvNW
 qNm+SIrClUhJJ8K2AP+gGR76Dchvg6Usrp2NQIAZ81kmPziZue3EyhWXFl49YHhjWI2nXrxqASe
 9bf2hsIdj4eRojO9LVPbOCK32EtHGX8=
X-Proofpoint-GUID: D1VVaEJA9alwe87ksijBzPe_20Mbk3u3
X-Authority-Analysis: v=2.4 cv=FoY1OWrq c=1 sm=1 tr=0 ts=6a4812f4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=YxFYfaw6DuWYmsw8bRUA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfX/8WAA1DpE1T1
 pjrUNSeO5/JgHMaY/FU5iEEo5uNA0bGJMYQns4ewbD+4sTPVf/vYN2vvNOcvMs5fQWb/TaWAvlL
 nV+LOTED4DfI/Gz5ZCLVwU2zgD2+wjk1Hx/TTfnqzZCyO5v4YIDUKZubpOYoZIxGqnUjdkvkaIT
 fo2UoIeiYe2jDbYQre2h8pX7EIwNBIO1uwUodJea+6BqYIjKtGe4qnF914ErnT4UIctYzvReu2M
 iXUyphXOPAapEOacx/6Y8SMLwMlli9Tn6m1AHxNGiaHwF9fAuXrqDFk3eQW5BFgDC/8eTUx7Wmz
 VNjMNq5LONTOMmaEgy5dz37+k01mOr+ZdElfeSHX9lUPJw37eUwEdxkK5RqRO++T4ShpM1zV+ps
 TfuJCB5vDRckatP1jkxchnTL+PQnprJwITOUUDRvZyw/8CBI3xT9MOiDLhZOxRYM84u3v1XIAp8
 SQRbN3PhFkx9MC96gLg==
X-Proofpoint-ORIG-GUID: D1VVaEJA9alwe87ksijBzPe_20Mbk3u3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030200

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index d4577663a1f0..2c7e54fc35d9 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -168,7 +168,7 @@ static int aspeed_gfx_load(struct drm_device *drm)
 		}
 	}
 
-	ret = of_reserved_mem_device_init(drm->dev);
+	ret = devm_of_reserved_mem_device_init(drm->dev);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"failed to initialize reserved mem: %d\n", ret);
-- 
2.53.0


