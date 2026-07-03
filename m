Return-Path: <linux-aspeed+bounces-4367-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB10C43602
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 05:41:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtGZ22rlLz2ynZ;
	Sun, 05 Jul 2026 15:41:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783108247;
	cv=none; b=XFaLGcRCh8gN3AKRfQuB3QJFNY2AvkIkai3E4jVykhxfsqnjC5w/PGlMPsL1+hKBxkz+THRywpTI+WugGY7SAJhdia2r3oki04dhK/z8f+4azc0S3349NOjfMZySPfBj2jGEynUMQdrDDggBfmf5pI9r1CJUX7ac6ky45+xPU8/b9tissWP0O6rSHYURHFbFPTt4I03DOS6ddFCP1DITH0Q5XX5JLm/gOYClHI7L3fyHbmmwzg5VZ4sti5jN2WElUOjl6RHCcFT4V8ZRwyjTZFz9jjoFw61PRcQBFe9Lf0L0foWN7BTix2+AEbPhFVRkJ+8BJWLj4du9qGr9XMj/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783108247; c=relaxed/relaxed;
	bh=71ffIbujQRJpACfwswiC++PljuSs1fWY5AHxmQ6jcq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yx8PxyoS2+f4XAfffcCSdSBbLn8hDFag6GHIns9CZFyiRtbKzFMQzpDWKwT0ZQp/RvLvMWycRckZWGYJ+ALcxA8oblUhV0pcp/jNPCmqCHzoyUByqzgQdwC9cjNypBRGoJ3L9F98cwnQNCD0vw/+1L47K3+HRLzUwI3akyUlUWEiMX5pwCQlPoPfxK+dDRYxIwSKPx4ckveDPMjKVJOYOnEjVmFkZPmjXwKChE56MufsjQdeVx0HFdsHos5OLdzxwO00iRT+DCfDNCMjkAC4yDjnjjp9JrCyX6jgqGnyNieResemtBBGLUOkncFix3Pal+zlHHv+cu9U5ZP2S/dowA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TvyBZCsm; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aKx6qrQX; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TvyBZCsm;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aKx6qrQX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsPWB2jYfz2xC3
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 05:50:45 +1000 (AEST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HiH8k677236
	for <linux-aspeed@lists.ozlabs.org>; Fri, 3 Jul 2026 19:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=71ffIbujQRJ
	pACfwswiC++PljuSs1fWY5AHxmQ6jcq4=; b=TvyBZCsmUFb6XP0nyeMDmZUr0d6
	QfdM5q7XKtRLmhSCsR87R7n24zAgPbqwXHbQbpbBrAfJN/3BoE2r95vk71p3+CBB
	ObOCk69OylcINhIYVL4FrfDARu/c4LAUFcKEv/9v6uWS8ukaPAWQuL8QDl4PNDO6
	WjFZPBHuitcjlSddKO9eskwZfTMHVM8nPVQ4qxvV0m/4929WyXvRmCnqcdLKEtVF
	BRpK7IT2oKjC1GZwOGyeLt9zFZnQ6XcJ6WQmmdDcXj7k39CKJTR5ZgMjHxxCKGYB
	3+KiUYnJ/K88oHwqwdihUAZhPh+yEQ4A7N5sgC8Y0wHfiGLi9JI0wWQhoHA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68u32kbh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 19:50:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-37d4eede8ccso771362a91.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 12:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783108243; x=1783713043; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71ffIbujQRJpACfwswiC++PljuSs1fWY5AHxmQ6jcq4=;
        b=aKx6qrQXrCdpdri7w5zOPqYCbc8L2ZvMi+QSEatSTFun/vtHsHgR27UxnW5ZJtgMEt
         EpyLXs25OjzGJHFZ3a6AjZoGZsyqiG+pF5SorBG2e7i2dtqfmf22P9Yuz4lFhZoUu0Zc
         gpDCu9Gc+lcmfQt7TjUVtgpyOthcxhbVmTg7k/uM72emwvzXMfqptjZD2oqwC1AHzdsC
         Ad1a53fCmwA4wKRx/ubw9YwejmR4/+mG6cACyOlBWNTYqKcVGZLpFPtSMlyOlWtVvImD
         a3iL4MmGbSO/coNuLkWcLUNDCjl7LmwTPqBtYkHcSnVDaYbUM0L7GHCQUL1sDiRMo0bA
         /k/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783108243; x=1783713043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=71ffIbujQRJpACfwswiC++PljuSs1fWY5AHxmQ6jcq4=;
        b=CC2d+ZdX5P29kv/mazhrmvYyv/1ARo7d4no91eE/UaUQWMxscjQpYRmxgkF5y1djGx
         fxh0UpvqyL1wNuxwUsWGKvUB/T+jtQIoPfbz92MUDCzXrfugllv5MBPeIB42/BIUXv0o
         j7GQPaofYyYsb2WEpjCViFuioFRc7Zvh9Cbcxj76/HweqZdkyKX92dopOLP/MnAAZFJt
         yIuKn/XDlvu7ZBXGE/omLkInly88jZj3+3VTR+iRWA0zXZqpOXZnNG+5Z2Rx0+jtGXp2
         5GWSWbZ94K27o/6Q1GctCXJQUKcOS4roVIlijiUWfYN2tv9JXMrRkKrYGJnlMEiSluGT
         o1tQ==
X-Forwarded-Encrypted: i=1; AHgh+RqaS1+1LikL64SEHfO2JemQo9v9HmJ5CWmWgXFEVgskNEkLHayxdM3l+1q4sOhN3315MxQUQZQFXjNPs0U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyeuFBvkPV138Ap9u3MqTxVW9qsOzWBYXGZx0/eVJZ/AqYO82Nu
	TVu06cfqr2OFoRrWIBO5cZ89sAp4nm6z7rWeCx68SLsYYZKvfqSCDY702SmwubeK5cbsQk7irrH
	abuKnpq4LlI8y7cDl4hIrHZppoABMPhsaKwZ+lzfRIUgEmRwcs9VB306aJiam270slxYBF308J7
	dr
X-Gm-Gg: AfdE7cmVNy2j5QNMpOcn2ZemlOTr86ozetXMiSbN4++Z+3Zv6G/3/XfLPxTTyyPevm2
	KkaF0OsmM8ST8ByRF+quSA3dvfu/oKBY+9xRRpUVhtCWkgiqh7ui92Yp15S2oJU5S7TXllAqgbB
	xDfXMNlnFu2+llx2CzJZ0mdmpRk7Aty9/I9VG38BnpFCbx86tBiMqfjCX3cgfbrs5BpciBGZwkL
	gwRfydpngRV51qYCdWJ1I0Xms4lrNjUu3YHm4FtuSRxe73/M5KidhnuuRKV0ex3FmxV68mBheIS
	BgJ0doETEL7qs86aK3FTb9kpl9um2RhA0P+fcqXLWjKuMv+RbNeg8Ru7AzuUlJZFVxTRW3NpWvM
	m0dyh8wOeAGP3PGqN2mf7bE5OLbYsW/wwQLNZ2w==
X-Received: by 2002:a17:90b:1dd0:b0:37f:f4ae:5f25 with SMTP id 98e67ed59e1d1-38293b9946cmr729520a91.20.1783108243303;
        Fri, 03 Jul 2026 12:50:43 -0700 (PDT)
X-Received: by 2002:a17:90b:1dd0:b0:37f:f4ae:5f25 with SMTP id 98e67ed59e1d1-38293b9946cmr729426a91.20.1783108242651;
        Fri, 03 Jul 2026 12:50:42 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:50:42 -0700 (PDT)
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
Subject: [PATCH 28/42] ASoC: mediatek: mt8189: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:41 +0530
Message-ID: <20260703193855.110619-29-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-GUID: GOl8RMBXS-Hry9sAZHAzPYGnMeTVN_w1
X-Proofpoint-ORIG-GUID: GOl8RMBXS-Hry9sAZHAzPYGnMeTVN_w1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfX8HwH3qdsm0jd
 sEAYhM7g1JRkgBWZbuPcbswJbh7ElpaBLx2C1B4h0Wmy5eeiUDulYhJ1cKldlf+olkdm8nxdfnp
 mnYTmByOO2PsiNqIyyv9RWzSw605B6s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfXz5HH/iim06QO
 kkGgcSJ83EI80kR500bbfDXPg+MQDu9mtiI6itrhbhf9w1Wj+bUMC/2jszK9M9Pu/Eu0iuX8whO
 l6M9Fw7dzmqzujePAdj1N+sFG4+6XU3AtbxaOtUqBp4yKKfT9uEmd42SurPpZasl7YASxtdzJT/
 uHI9JsSbm9qxauDtS9XgqacJUF5BwFaGIsWFdIRj7bfKfeoroKxunsUheIt5vFFh5LoE6TW59ZO
 g+ack+TojSlLgvFjT8C/19l/zEMgKRblHsFRp7pb17PJgfg9cy9lm0iJtQlZyLdTR4A/Cu0LOx1
 UdlMpu8KH2YNnQ9C5AZItBhKAWpDQgc4XFjRjQEULDjfZ0vFzI9YbPn2RpJIOCzsZM2ta4j160N
 Nml+zhxos5uFp54pvAaju8EWxi5LjNMAduG9c5NOcY9LFkuJOXLar0iNnfiGKvFmLFvKsQWrDsq
 IFGnHTnQqI96524qfNQ==
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a481294 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=vpwXisbvDR7QvT6TCt8A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030200

Replace the hand-rolled devm wrapper (mt8189_afe_release_reserved_mem +
devm_add_action_or_reset) with the standard
devm_of_reserved_mem_device_init(), letting the device resource manager
handle cleanup automatically.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/mediatek/mt8189/mt8189-afe-pcm.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/soc/mediatek/mt8189/mt8189-afe-pcm.c b/sound/soc/mediatek/mt8189/mt8189-afe-pcm.c
index 77cf2b604f6c..04baf7d9132a 100644
--- a/sound/soc/mediatek/mt8189/mt8189-afe-pcm.c
+++ b/sound/soc/mediatek/mt8189/mt8189-afe-pcm.c
@@ -2421,11 +2421,6 @@ static const struct reg_sequence mt8189_cg_patch[] = {
 	{ AUDIO_TOP_CON4, 0x361c },
 };
 
-static void mt8189_afe_release_reserved_mem(void *data)
-{
-	of_reserved_mem_device_release(data);
-}
-
 static int mt8189_afe_pcm_dev_probe(struct platform_device *pdev)
 {
 	int ret, i;
@@ -2439,16 +2434,9 @@ static int mt8189_afe_pcm_dev_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = of_reserved_mem_device_init(dev);
-	if (ret) {
+	ret = devm_of_reserved_mem_device_init(dev);
+	if (ret)
 		dev_warn(dev, "failed to assign memory region: %d\n", ret);
-	} else {
-		ret = devm_add_action_or_reset(dev,
-					       mt8189_afe_release_reserved_mem,
-					       dev);
-		if (ret)
-			return ret;
-	}
 
 	afe = devm_kzalloc(dev, sizeof(*afe), GFP_KERNEL);
 	if (!afe)
-- 
2.53.0


