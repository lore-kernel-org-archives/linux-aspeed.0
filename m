Return-Path: <linux-aspeed+bounces-4372-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4A6C43458
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 05:42:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtGZ82qgfz2yjw;
	Sun, 05 Jul 2026 15:41:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783108029;
	cv=none; b=I4cyqU0zVkpaNmAPt8PlgJuWLcSKRvrX41L+UdiHAI2x5Fk6BI3CbfVYUnPeyQD/ap1/uAl8DO4YNj/Cq3WaDY131PGzJNWnsGyrBAw8A6BjIwzg65WBL+9EWTNdT7J9gLRrvMMy8tx23AXVP52nJa9VLuE7rOl3eFx+FO3DN/LsjPp2WG9376wta1NQ/xRKSA98GmOqjVwulZ5hfp5x/xTpIfidYVxpSYN3eqOCb3g39WvLcq4kYiwcMQEOz0Mciy681AaLvxC7TrmPeCy7XIV0CBxt3L0J90pnErwdeUQAMcmx2x9v6lL+iLuHZCSkKGRVWXPxlD54RB4ob0eHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783108029; c=relaxed/relaxed;
	bh=TQ2PuvPwxYkWt/yOA3YLy/RG2quNv49+20ByVVAjYo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmmpwD5v3gzJNx/6I9CdPfW3KfVGysrU9CPqQVOyAfSMyw3HYuAFBpvCvC9ajkOZKWDLF+o0h012At6FlO0CFcHEQPeAiAl9eMedmJVYJEvMETsnnn7wl+JrMxOLME9wG8J0W2v191jnktYV839pApoJK9WL3d04k4isK1aJsi6vkD/ypWHJIuDEmB5IAt+q85n+3OpBmtStiqH2aN2sWMvuheP+carPVSsizIlzNx+31qZ/5B5/NleRrtGDFrawuKuLCLYyFdR9lDyPPQGRd0JezSaLDAf2FO5y/ekJbpqoEdi8PqZHloI1BK22kjIz82VzWr0uKEnjsH+36FHyPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DY4QvfxB; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IqWKJ5bW; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DY4QvfxB;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IqWKJ5bW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsPR10Wsyz2xF8
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 05:47:08 +1000 (AEST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663Hjwwt687143
	for <linux-aspeed@lists.ozlabs.org>; Fri, 3 Jul 2026 19:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TQ2PuvPwxYk
	Wt/yOA3YLy/RG2quNv49+20ByVVAjYo8=; b=DY4QvfxBiKqNUjE+FO+PvI+2fN/
	tWkhy2AkYZlVHf5nAR/ui7uQa+iRBuLntvRwgE0dQFPkqzoLgEMw0zeqlayJ/Gel
	onjx03ASz3rWePMh+qGM/a04eeA80fikGiR1H9p8mrt2w/n2sWBvv1DztzavFtXL
	/XeeldILoOCBesxiNfgJ+C4BADjhG2L6FEbE1s+veZRH1J/q5MN7YvhlEZTBrt1i
	tgodfKGbcSEh9Oqr/vvq610x+ieI1FDFMT4rZr2sB2q1M3/nEMAHspCXkJy5Qnpy
	5vg2JXZqEzbKmYlRZWLE71DuByFP/kvnxPtKLGkBzFPdFWg8Hz/Jm6Zj7cQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qckfam-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 19:47:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38112fd8b48so980243a91.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 12:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783108026; x=1783712826; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQ2PuvPwxYkWt/yOA3YLy/RG2quNv49+20ByVVAjYo8=;
        b=IqWKJ5bWKqzcG8DFHrWm3p5mS6Lt2Rl6OoPyUGSw0uqGl3cg5PPus+26Bd7MMI1zka
         h+NFzEDSEqUMbFrVM6l4qNUDbWNe0W1hvU7Y/EMp+5b4lIbDV+lFMZYgsmxRP+K8qu71
         PolHQ3hli8f2lFVXVSN+CAv2n20Ex84FAma1yYKwU+Wv95U6mFN/zi5OIpypjA4mrNDa
         LSYa83QKPc9DB/YGVASWQy+i68kAd/pM3+IKRsg772OcAuF1rzBRZEbLgMEDYBYfZWM8
         D1ekQiOLys9MXeFAbs4BRRdU5GcWYLkwGQEQFvSWFSLFqgXgFf58zHRsYcI7cL2UypD7
         0jTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783108026; x=1783712826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TQ2PuvPwxYkWt/yOA3YLy/RG2quNv49+20ByVVAjYo8=;
        b=XHVoUdCm8w23IbV4AE3lHd0iGjZBvnGayVGelTho3MpEj2bK9Pd+aS9qMd5IPCjvdC
         lXFYrZZWo9i2dhKnefV4tMce+P3tlDlcvMy/ghjDSH228r6EHRCOcrbbBcCqu/jOORUy
         92edoSj13wjmhp3r043myF4rcGbA/JKsqTTQgYWCltX0bNBsJV4ttg5gTWvw3DYxo/fv
         qKuYXxE7CpfHmayzmnSmkHJZh+IwfLv2fmqyUKmtHMJMR+IgcZCAycwyL18lcGxUQiJW
         6kvireQLE3mUObOpxqyT0gRuaN5z5LSlKTr8ef60ioD0ne7RcVH8PIL3wgiPXOims9Ut
         R7Mw==
X-Forwarded-Encrypted: i=1; AHgh+Rrh72ltgylLs67FDghe3tYcq2+P2Gye51Io8oz6vW3FoapPu+aACUXbaU3GVQajIlmaNpal6xQHRnGr5MY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwFxWS/iNe79upRpLmFjV11ZMYFS+oOsnOi0kV5HsjW0xTR8Lv4
	6FtEPW4+eWoVR8+zEartIebAiB0S3yLSWEyZf+uGtQ0+sXTI/3TNnP+em9paalhNiw6YGA9e4Cq
	MELOZC4EhOqoD1Xzf9ltFAbIovrJaHEMeLioXI8edNFt9eui0Y1CFiKhLP682MWMwviO+
X-Gm-Gg: AfdE7ckUBM960h64TtRJFwXZf7eW+bjhQsh0HYKeZS+w4FLPUBM0QkegTfDFxDUcQu2
	e27PrPRU2sSYWsVqDMDxn6jPgTxeLW/EfQf0j+0uXZPGommsVPY2QPtxfAZf60esbaG+6QOhsxh
	Z3kZd9cZbrGR5IaUw8hypZS4rQN+FyW5hSrOCioxnLiJPEm9YTsBo/jqlLMRDpZmOoFbngaNORS
	O1wRksrSAV7h/HV4NyhKlt4rImGkObN+HB7/Erc/+cagJ31EQr5vb47tIsqYF7u1CdMyjaw8axs
	3jpvMB6wJ6bMGDwfCeM3l+ELt1EyFpn8/YgqhHBn3crPlJUkii3WlnXHJ/7VRrYImWywoZPh1Me
	EOAP4Fa92rBh3AnEKMAG/Rj7L4Pia7Mib9weIdg==
X-Received: by 2002:a17:90b:1e48:b0:37f:d262:1e0a with SMTP id 98e67ed59e1d1-38280d999c9mr747522a91.12.1783108025409;
        Fri, 03 Jul 2026 12:47:05 -0700 (PDT)
X-Received: by 2002:a17:90b:1e48:b0:37f:d262:1e0a with SMTP id 98e67ed59e1d1-38280d999c9mr747443a91.12.1783108024778;
        Fri, 03 Jul 2026 12:47:04 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:47:04 -0700 (PDT)
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
Subject: [PATCH 19/42] drm: sun4i: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:32 +0530
Message-ID: <20260703193855.110619-20-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-GUID: PRRDE9jflVb8FbmzUqTx0fXFRS8TFHgx
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a4811ba cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=UuaWy5wPpgFSIu4BNl0A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: PRRDE9jflVb8FbmzUqTx0fXFRS8TFHgx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfXyJruLVbXqbIW
 pCgKu9urEaq8jxT0hOAgSQmiHgNV1q0QSVjFvWOlfoe1yYtAx3wSQR8f80g1Hr1uwhysv6o0MnP
 DGccYSlMtChq8CpjEiCDTZDvuKdlb2Hjre/Ld8PtKaJi60p4QwuB9aK8CNq0GVNd2UTBjUKV/Lk
 oILP14fyUvGQpt5zPAath2qDhVGX80pusd+eDxdMruJfomnNt0GMcMdKz1nmR+Hz6srAZrzsldk
 fXw9Mj/vDxJTQAKSU56L84Ktu534Fw+M2YiRWr+TG43Zy7lzQKvgxde0eRDUKlaf/ov/14HAtUb
 4WOhCZIK/AHRD6uCoTLHq1Cs9g0jvNo0y4XfYJOhI/m80hRcmH5mhfTpalwNlcKEzbRJrqjX0q0
 yqujzICHU2LHmj7p8c9av9WwmAfYkceqySlTuhllo9gcjVD0Yj15nu+Dnscihdje//Y3vZOTNCD
 6laZjHe84dJ02Idv2FQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX8aPl6qLx35qV
 4zCkJzbn8oxwQqQ1WsIbz9U6ralVw1JD7lQeo75+Rpr+hb4jZrHKbJXRnY8qmD48NNtQ3qKJBFT
 xzauSpnS936RWzvx/XaZcw0OM/CKSlE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030199

Use the devres-managed devm_of_reserved_mem_device_init() instead of
the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
pair, letting the device resource manager handle cleanup automatically.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 8a409eee1dca..5ca7b6f4764b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -80,7 +80,7 @@ static int sun4i_drv_bind(struct device *dev)
 	INIT_LIST_HEAD(&drv->engine_list);
 	INIT_LIST_HEAD(&drv->tcon_list);
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret && ret != -ENODEV) {
 		dev_err(drm->dev, "Couldn't claim our memory region\n");
 		goto free_drm;
@@ -125,7 +125,6 @@ static int sun4i_drv_bind(struct device *dev)
 	component_unbind_all(dev, NULL);
 cleanup_mode_config:
 	drm_mode_config_cleanup(drm);
-	of_reserved_mem_device_release(dev);
 free_drm:
 	drm_dev_put(drm);
 	return ret;
@@ -142,7 +141,6 @@ static void sun4i_drv_unbind(struct device *dev)
 	drm_mode_config_cleanup(drm);
 
 	component_unbind_all(dev, NULL);
-	of_reserved_mem_device_release(dev);
 
 	drm_dev_put(drm);
 }
-- 
2.53.0


