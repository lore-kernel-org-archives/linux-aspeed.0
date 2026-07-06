Return-Path: <linux-aspeed+bounces-4404-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C14C43458
	for <linux-aspeed@archiver.kernel.org>; Mon,  6 Jul 2026 12:00:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv2x36Zdsz2yfS;
	Mon, 06 Jul 2026 22:00:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783326763;
	cv=none; b=bPFd8Hd0puWl+PizbXdKwniEAB1Msn6myRt+ZKIBtl1fWezc+uwvJLyg3oySUo7x52FOpPtv1r52vZmDkLWSDXTNJaELSx91yoTzXlg8JkgY9jcZXm5jGeQNqSGQLNMG0UETQJRkQJkeClBIN97mX1B29ZGyxgVh1YH1ZXbO39NTC3PGqGacEHwzOC9Y36xOXm5DNxAkdZSdpd4fxHcY0a84dLwfpPTCAzMIZboGOtkCLGq3i0ShKpzu2OlryASx/sbv2xJY5JLs1Px26YfcQO+Nq8wnDZQLumOqM4O2uDo0KdiR/PE1SciDoVIVTFNVr1iEvo5mJQ1AwD+ch3gTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783326763; c=relaxed/relaxed;
	bh=u0chLt5mv9z2EayzuLPxsiMUHQpTGQFKrRQIdFhdccs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JliNfRW4lwL+jKS+Nub7pKt14aKdij5vcj2ZB5gr7itnZGw6kce7BMQgGtSoAU/ceOBtonf/Ad0dTvEa14Kw7/q+vwAugbSZtwxewcx7Ig2W8GKG5GyFEeh6Q4rHTYu7Z17wgjeAKXESJfBqhNaYf40Ul0hn/fDjPTBt/Eeu2svjRAujJmtvH0Pi55TGbKciL9lirP9iHehPcxeWX2+Oi7+T8nyWpSj6QP0Ez0uSSYLuqF9hYeURQXLz8Ul1qaf70/Fq8XehjWRQaJjSQTvJ/HDOJftQw2Fv3ZPML9LWbcBX+lo9zDTVr/wzKPpAO4sX4zYq2pozmunRpp/6nMkxWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tt1g9aWR; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WIwDA1cL; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=konrad.dybcio@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tt1g9aWR;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WIwDA1cL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=konrad.dybcio@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtyKQ6D2Qz3bqD
	for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 18:32:40 +1000 (AEST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66641Zq93594598
	for <linux-aspeed@lists.ozlabs.org>; Mon, 6 Jul 2026 08:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u0chLt5mv9z2EayzuLPxsiMUHQpTGQFKrRQIdFhdccs=; b=Tt1g9aWRdhyI3BpO
	bvxcoGq7kYOipwI8sI86zxkmNdiblCbEIIy0D6ekqZISLjLM2a33y7RzY76GbicN
	Opq7MS5ZQyamKmgeZkedVYAFfw1KRPYi8hl3Y7h7kuir3yf0DUot7pMFqfcV2RX7
	X6ly6HXPcg70fqU+dH3N/iuMe5KE0DqLRF0s4qeJ6w03zgeEubZlkFJyH6FDUo2t
	Et+Ig2j6kpZC/v51lNaj0P+xbzzB2QuKkvGbM4AuZdQSxZloAH/4eroeiJwOgPxx
	kOehTF0x3+rZPy9CPDosN5R/kMP09AyBofAR6Pe/VMGVWMs1S1vCPm7OD23UZkSl
	ZSPxow==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qvgwmjk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 08:32:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfe75b7dbso9086621cf.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 01:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783326758; x=1783931558; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u0chLt5mv9z2EayzuLPxsiMUHQpTGQFKrRQIdFhdccs=;
        b=WIwDA1cL4PaI6QW8flEPPuWYp0UpI8gRPHswhm8Fp7KiWcURSzrntCz1SQh2yVkJ54
         99KPoi6tZuz4jXtuUQzjn50pKEtM88ED3rn9Pn2evgD+V+2k7I6KOjt51A1ZGPZ2AsPx
         WaixoRfZcbDqKMzN1aNGcgz7+nWZ8x6e+6S3Zt7fVzzlIdp3LpZ1j3+ru2bDTC/vT5+3
         lK0lKvgfJjDeYJ2feizbSw2VBvpaMIpYqAN165Bv1Krr6qqtAXk+67rJnXr4IZiBvmma
         FkxUcjbpSY9LCprqUOdWJKC951jsq0YeozV80YvH3BQ9DKIvLUum4h7LwlhnaaS+eEax
         MAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783326758; x=1783931558;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u0chLt5mv9z2EayzuLPxsiMUHQpTGQFKrRQIdFhdccs=;
        b=oE5ef6xllB5D1O3lEoHHlIL+lkgq7LfaJFvhsazY7DT6spZ1H3NNkU04YIXVWwXK8w
         OFaxO9QQorftSjkqyrkickC8o8aQ2eAe8H6/SvcCiOk0z5PyJmAvJ7q0koypVZg1eE8/
         FvuZhhsOtjdI6CO2dhcs5mBU61Ll+2XKvRKMTx/MqqjH+TTJD+KQOEOksxuPyh8Ze4Pc
         7rPBN7Ukl6lHFni8o35V5nn81V/M45+ePvgC+UI7Ik5uTszlpoIQn5B6sjWvQUtpKeSZ
         qvDg1nDewH+r6GPkbwzqGq9Oxy0rc669T6wRgX+X6ULI8vLKDcPQsyocQ4EYc4B1kuJ4
         v3sA==
X-Forwarded-Encrypted: i=1; AHgh+Rqp3HnLrQ2SkyroxGqGd7COO/jvfs06veqYgl9qruGaFlMdnej6BiuqJXGwhBzQR5PeUu0Xc2eE7R/d2hc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwPs06u9OiW7VDZ7QfsQylc4QVn+vtAC9ogkGKW5Vwv9o5CQ03U
	GCMb1TzruQa9Pe894jvUq2iTqrDJCBujt0Z7888nk0a5J3GAaK6D5xM0ko/EKi2yAwiNZx0Pjd8
	xknIKIb8Rov2c7BZdqsvwe8pE5vN1q6SLghEtNXoJMYq3KuahirVgMucCPBPZnuP23cjc
X-Gm-Gg: AfdE7cmMjFXoq6HHp/fe5usDwB37Bs3Av8uPNkHAbYWnNNtm7G0DeoE+n+/mmK7PQ8/
	iACBp9w1/Zs9zJdKQU/CvipTVoiN6t7oq7+oFtBdOzbXQQzzfp5tDrKfBfkkbXdguocvujUkQWH
	Cb4WxtW3SVnjY8sSNR824tcLw2ZkifPTnhhZltq6hWu+aLjsRJ765hc34vLFY9Oe6jChqGVzwhW
	1yc9AYwiu3PrFiMHbggWBwOJAfeQIFfYByBpEYP7uZYgU2oEeo5bMFMXM46QWUulJ5NBMr3BZpF
	zgVUx7vkwrbAHh+cB643sBAMdN4q8neosKNP6XLsN55BZn7mhVtv2hy+QcDdmvLh4wUuGAcL+2r
	RWzbidsVWPo8rJeTtsYZg3ucsKQpADxWGGfk=
X-Received: by 2002:a05:622a:82:b0:51b:ff78:f229 with SMTP id d75a77b69052e-51c4be04aeemr79016511cf.5.1783326757958;
        Mon, 06 Jul 2026 01:32:37 -0700 (PDT)
X-Received: by 2002:a05:622a:82:b0:51b:ff78:f229 with SMTP id d75a77b69052e-51c4be04aeemr79016281cf.5.1783326757507;
        Mon, 06 Jul 2026 01:32:37 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6093786sm694743966b.20.2026.07.06.01.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 01:32:36 -0700 (PDT)
Message-ID: <f1e7ef14-7186-4854-a832-a34596d3313f@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:32:27 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/42] firmware: qcom: scm: Use
 devm_of_reserved_mem_device_init()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
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
        Alexey Brodkin
 <abrodkin@synopsys.com>,
        Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>,
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
        Ge Gordon
 <gordon.ge@bst.ai>, Adrian Hunter <adrian.hunter@intel.com>,
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
        imx@lists.linux.dev, sound-open-firmware@alsa-project.org
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
 <20260703193855.110619-4-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260703193855.110619-4-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VvoTxe2n c=1 sm=1 tr=0 ts=6a4b6826 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=7yxQZbK4ublJ3xJh_1MA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: z2JeasfkD-UcyrARHZTQVO9BM6xNpwCP
X-Proofpoint-GUID: z2JeasfkD-UcyrARHZTQVO9BM6xNpwCP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX6HhK7F6xPraa
 DnDsHERKML/gX16drRKt33BnExU4QTvTNwoj8RueU6obmSOz58UX6ceqbwwuRLFofDqP7SYvXQ9
 dgRKmwaTLnsyMKwZ7lIYC9gC0beVH64=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX4la9klOl4wOP
 mwPXOqEt5bAP71y6bUHoaDru1hJ5ycpaDTzT5CcOiEZ2TCCRUQQI1t09hmUkI7l3oN6V8YCEmfT
 rNfkCkY/WdWCDQjfFjkwJuCH6tPdnpV3rpfAU4iHB5pyHNyCOYCfN5ZOk0SiwVxKWXY0QtnQQXV
 omDoJ5v7bhk5kOKEWhuofYiaUx+Lytxvcqt7w6lBgTMiHTA1mhbOMKTkFYasxMoYHsax7JBKCtD
 D6XBGUmJykCCpXpTHVZpJKn+wuf28cieUZhjEy8S03aiqytuPBaXYmBQGhmXlfrCAmoFy8XU5nn
 HbrhdxlbJduvGNMdKqwAh/FMLZjPCFCkSB+d17BPTuMPsRPG4SZA8Qg1AP5VJGV4WEFG3pyBB8W
 K6gHGZsc3yae6sJUQghGjdhcmXsB49Wt111LhiLrgoSve6+OEgKU0MwCyF/5m6lJicvMdciuahV
 Tbkbnj4Fbr5VgvmuK3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060083

On 7/3/26 9:38 PM, Mukesh Ojha wrote:
> Switch from of_reserved_mem_device_init() to the new resource managed
> devm_of_reserved_mem_device_init() so that the reserved memory region
> is released automatically on probe failure or device unbind. This
> eliminates the err_rmem cleanup label and the need to call
> of_reserved_mem_device_release() explicitly on error paths.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---

Thanks!

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

